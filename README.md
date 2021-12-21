# AWS_auditor
AWS audits across Organizations' accounts (Role Creation only)



LIST AWS ORGANIZATIONS' ACCOUNTS INTO A SINGLE BASH ARRAY:

```bash
ACCOUNTS_IN_ORGS=$(aws organizations list-accounts --query Accounts[?Status==`ACTIVE`].Id --output text)
```
FOR THE AUDITOR:

```bash
for accountId in $ACCOUNTS_IN_ORGS; do <aws cli API calls> -A $accountId; done
```
