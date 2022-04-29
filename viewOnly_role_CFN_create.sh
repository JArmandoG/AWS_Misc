#!/bin/bash

# "auditor" for easy recognizable user/group/policy
# USAGE:
# ./this_script.sh <ACCOUNT_ID> <CFN_CREATION_FILE.yaml>

ACCOUNT_ID=$1
CFN_FILENAME=$2

aws cloudformation create-stack \
  --capabilities CAPABILITY_IAM --capabilities CAPABILITY_NAMED_IAM \
  --template-body "file://$CFN_FILENAME" \
  --stack-name "AuditorExecRole" \
  --parameters "ParameterKey=AuthorisedARN,ParameterValue=arn:aws:iam::$ACCOUNT_ID:root"
