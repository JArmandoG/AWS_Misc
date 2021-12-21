#!/bin/bash
export AWS_DEFAULT_PROFILE=default
export ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' | tr -d '"')
aws iam create-group --group-name Auditor-group
# Keep the Auditor-policy.json in the same folder
aws iam create-policy --policy-name Auditor-Policy --policy-document file://Audit-Policy.json
aws iam attach-group-policy --group-name Auditor-group --policy-arn arn:aws:iam::aws:policy/SecurityAudit
aws iam attach-group-policy --group-name Auditor-group --policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess
aws iam attach-group-policy --group-name Auditor-group --policy-arn arn:aws:iam::${ACCOUNT_ID}:Auditor-group
aws iam create-user --user-name auditor
aws iam add-user-to-group --user-name auditor --group-name Auditor-group
aws iam create-access-key --user-name Auditor-group
unset ACCOUNT_ID AWS_DEFAULT_PROFILE
