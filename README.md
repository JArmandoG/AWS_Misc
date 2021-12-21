# AWS General Info

---

# AWS Auditor against Organizations' multiple accounts

(Forked from the Prowler project, with customized scripts)

Cloudformation template - create an auditor role
[auditor_role_CFN.yaml](auditor_role_CFN.yaml) 

Creation of the auditor template (Leveraging CFN template) - bash script:
[auditor_role_CFN_create.sh](auditor_role_CFN_create.sh)


LIST AWS ORGANIZATIONS' ACCOUNTS INTO A SINGLE BASH ARRAY:

```bash
ACCOUNTS_IN_ORGS=$(aws organizations list-accounts --query Accounts[?Status==`ACTIVE`].Id --output text)
```
FOR THE AUDITOR:

```bash
for accountId in $ACCOUNTS_IN_ORGS; do <aws cli API calls> -A $accountId; done
```

---

Credits: Prowler
