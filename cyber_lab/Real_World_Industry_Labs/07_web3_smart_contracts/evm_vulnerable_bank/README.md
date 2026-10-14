# Web3 & EVM Smart Contract Security Auditing

## Overview
Audit and exploit Ethereum smart contracts: Reentrancy bugs, flash loan price oracle manipulation, and arithmetic flaws using Ganache.

- **Default Port / Access**: `8545 (EVM RPC)`
- **Directory**: `Real_World_Industry_Labs/07_web3_smart_contracts/evm_vulnerable_bank`

---

## How to Solve & Practice

1. Start the Ganache local blockchain: `docker compose up -d`
2. Connect Remix IDE (`https://remix.ethereum.org`) to 'Custom - External Http Provider' at `http://localhost:8545`.
3. Deploy a vulnerable EtherBank contract containing a withdraw function that sends ETH before updating state balances.
4. Deploy an Attacker contract with a `fallback()` / `receive()` function that re-enters `withdraw()`.
5. Trigger the attack and observe complete drainage of contract funds.

---

## YouTube Walkthroughs & Solving Guides

- [Smart Contract Programmer - Reentrancy | Hack Solidity (0.6)](https://www.youtube.com/watch?v=4Mm3BCyHtDY)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
