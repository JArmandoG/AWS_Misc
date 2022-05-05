function _CHECK_PROGRAM () {
		echo "[i] Checking if $1 is installed and on the user's path..."
		sleep 0.3
		if ! $1 --version &>/dev/null
		then
				echo " - $1 not installed"
		else
				echo " - Ok"
		fi
}

_CHECK_PROGRAM aws
_CHECK_PROGRAM curl
_CHECK_PROGRAM carl

POLICY_FILE_CONTENT=$(cat <<-END
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "$ACCOUNT_ID"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
END
)

# Create JSON file
JSON_FILE=trustPolicy.json
echo $POLICY_FILE_CONTENT > $JSON_FILE && echo "[+] New JSON file created: $JSON_FILE" || echo "[!] error creating JSON file"
echo " - AWS Execution / Policy creation in progress..."

ROLE_NAME='assumeRole-Role'
SESSION_DURATION='43200'
POLICY_DOCUMENT='trustPolicy.json'

aws iam create-role \
		--assume-role-policy-document file://$POLICY_DOCUMENT \
		--max-session-duration $SESSION_DURATION \
		--role-name $ROLE_NAME \
		--permissions-boundary arn:aws:iam::aws:policy/job-function/ViewOnlyAccess &>/dev/null \
		&& \
		aws iam attach-role-policy \
			--role-name $ROLE_NAME \
			--policy-arn arn:aws:iam::aws:policy/job-function/ViewOnlyAccess &>/dev/null && \
			echo "[+] 1/1 SUCCESS CREATING $ROLE_NAME"

# Get Role's ARN:
ROLE_ARN=$(aws iam list-roles | grep assumeRole-Role | grep Arn | sed 's/"//g' | sed 's/,//' | awk '{print $2}')
echo "------------------------"
echo "[i] Role ARN: $ROLE_ARN"
rm $JSON_FILE && echo "[x] Deleted $JSON_FILE"
