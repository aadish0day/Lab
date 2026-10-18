# OWASP SecureBank: FinTech Business Logic, Concurrency & Mobile Banking API Pentesting

## Overview

OWASP SecureBank is a vulnerable-by-design banking platform developed by SSRD and maintained under OWASP. It simulates a modern financial institution complete with customer portals, checking/savings accounts, wire transfers, dynamic transaction histories, and loan processing.

While generic web targets emphasize classic injection vectors, financial applications are dominated by **Business Logic Flaws (CWE-840)**: floating-point balance manipulation, double-spending through concurrency race conditions, negative quantity transfers that credit rather than debit sender accounts, and Broken Object Level Authorization (BOLA/IDOR) on bank ledgers and statements.

- **Primary Web Portal**: `http://localhost:8118`
- **Backend REST API**: `http://localhost:5001`
- **Docker Shortcut**: `./lab start securebank`
- **Container Name**: `cyberlab_realworld_securebank`
- **RAM Footprint**: ~350 MB (ASP.NET Core Web API + React SPA)

---

## Architecture & Technology Stack

```
+-------------------------------------------------------------+
|               Client Browser / Burp Suite / Mobile          |
+-------------------------------------------------------------+
                               |
             +-----------------+-----------------+
             | (Port 8118)                       | (Port 5001)
             v                                   v
+-------------------------------------------------------------+
|                      SecureBank Container                   |
|                                                             |
|  [React Frontend SPA (Port 8118)]                           |
|    - Dynamic Transaction Dashboard                          |
|    - Wire Transfer & Currency Exchange Forms                |
|    - Interactive CTF Challenge Grader                       |
|                                                             |
|  [ASP.NET Core REST API Engine (Port 5001)]                 |
|    - JWT Authentication & Role-Based Access Control         |
|    - Double-Entry Transaction Ledger Controller             |
|    - In-Memory / SQLite Relational Database Engine          |
+-------------------------------------------------------------+
```

---

## Key FinTech Vulnerability Domains & Attack Exercises

### 1. Negative Transfer / Inverted Arithmetic Exploit

- **Target Endpoint**: `POST http://localhost:5001/api/transaction/transfer`
- **Vulnerability Mechanism**: Lack of signed-integer validation allowing negative balance transfers. In double-entry bookkeeping:
  $$\text{Sender Balance} = \text{Sender Balance} - \text{Amount}$$
  $$\text{Recipient Balance} = \text{Recipient Balance} + \text{Amount}$$
  If $\text{Amount} < 0$, the sender balance increases while the recipient balance decreases.
- **Attack Walkthrough**:
  Send a transfer request with a negative value:
  ```bash
  curl -X POST http://localhost:5001/api/transaction/transfer \
    -H "Authorization: Bearer <TOKEN>" \
    -H "Content-Type: application/json" \
    -d '{
      "sourceAccountId": 101,
      "destinationAccountId": 102,
      "amount": -5000,
      "description": "Wire Adjustment"
    }'
  ```
  Inspect your account balance; account 101 is credited with +$5000.

### 2. Double-Spending Race Condition

- **Target Endpoint**: `POST http://localhost:5001/api/transaction/withdraw`
- **Vulnerability Mechanism**: Time-of-Check to Time-of-Use (TOCTOU) concurrency gap. The application reads the balance, verifies sufficient funds, delays momentarily during ledger writes, and updates the balance without database row-level locking (`SELECT ... FOR UPDATE`).
- **Attack Walkthrough**:
  1. Open Burp Suite Turbo Intruder.
  2. With an account balance of $100, dispatch 20 simultaneous withdrawal requests of $100 using parallel HTTP/2 single-packet synchronization.
  3. Verify that multiple withdrawal requests succeed before the account balance drops to zero, yielding thousands of dollars from a $100 deposit.

### 3. Broken Object Level Authorization (BOLA / IDOR) on Account Statements

- **Target Endpoint**: `GET http://localhost:5001/api/statement/{accountId}`
- **Vulnerability Mechanism**: Server retrieves account data based solely on the URL route parameter without verifying that the requesting user's JWT identity owns that specific `accountId`.
- **Attack Walkthrough**:
  Iterate across account IDs:
  ```bash
  for id in $(seq 1 20); do
    curl -s -H "Authorization: Bearer <TOKEN>" "http://localhost:5001/api/statement/$id" | jq .
  done
  ```
  Full financial records, transaction histories, and customer balances are returned.

### 4. JWT Key Confusion & Algorithm Downgrade

- **Target Endpoint**: `POST http://localhost:5001/api/auth/token`
- **Vulnerability Mechanism**: Weak HMAC secret key verification or tolerance of `alg: "none"`, allowing attackers to forge arbitrary administrative claims (`"role": "BankAdmin"`).

---

## Defensive Remediation & Hardening

1. **Strict Input Range Constraints**:
   Enforce non-negative, non-zero values at the schema validation layer:
   ```csharp
   [Range(0.01, 1000000.00, ErrorMessage = "Transfer amount must be strictly positive.")]
   public decimal Amount { get; set; }
   ```
2. **Database Concurrency Control & Row-Level Locking**:
   Wrap financial transactions in serializable isolation levels or acquire pessimistic row locks prior to reading balances:
   ```csharp
   using var transaction = await _context.Database.BeginTransactionAsync(IsolationLevel.Serializable);
   ```
3. **Explicit Owner Authorization Checks (BOLA Mitigation)**:
   ```csharp
   var currentUserId = User.FindFirstValue(ClaimTypes.NameIdentifier);
   if (account.OwnerId != currentUserId && !User.IsInRole("Admin")) {
       return Forbid();
   }
   ```

---

## Video Walkthroughs & Technical References

- [How a Simple SQL Injection Bypassed SecureBank's Login](https://www.youtube.com/watch?v=tGCIOk4XOgg)
- [OWASP SecureBank Project Repository](https://github.com/ssrdio/SecureBank)
- [OWASP API Security Top 10 Specification](https://owasp.org/www-project-api-security/)
