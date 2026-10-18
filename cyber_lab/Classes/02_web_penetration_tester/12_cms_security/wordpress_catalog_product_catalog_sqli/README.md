# WordPress-Catalog - Product-Catalog-SQLi

## Overview

- **Vulnerability ID**: WP-CATALOG-SQLI
- **Application**: WordPress-Catalog
- **Port Allocation**: Port 8511
- **CLI Shortcut**: `./lab start wordpress-catalog-product-catalog-sqli`

## Vulnerability Description

WordPress Product Catalog 8 plugin SQL injection vulnerability in search parameter handling.

## Quick Start

```bash
# Start target environment
./lab start wordpress-catalog-product-catalog-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-catalog-product-catalog-sqli
```

## Verification & Exploitation

```bash
curl http://localhost:8511/
```

## Video Walkthrough

- Walkthrough: [WordPress-Catalog Product-Catalog-SQLi Security Assessment Walkthrough](https://www.youtube.com/watch?v=DhnYtHPeu_4)
