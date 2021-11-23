#!/bin/bash

# Genearates temporary AWS credentials using your MFA device (12 hour duration).

# Create a master file (.store) that will act as the source of your AWS Prod and Dev credentials
if [ ! -f "${HOME}"/.aws/.store ]; then
  if [ -f "${HOME}"/.aws/credentials ]; then
    cp -a "${HOME}"/.aws/credentials "${HOME}"/.aws/.store
    echo "Credentials have been backed up and stored in ${HOME}/.aws/.store"
  else
    echo "There is no credentials file located in ${HOME}/.aws/credentials" && exit 1
  fi
else
# If the master file already exists, replace the configuration in credentials with .store, for AWS CLI to read your profile keys
  cp -a "${HOME}"/.aws/.store "${HOME}"/.aws/credentials
fi

# Query IAM to get the username associated with the keys in the credentials file
username=$(aws iam get-user --query 'User.[UserName]' --output text)
if [ -z "${username}" ]
then
  echo "Can not identify who you are. "
  return
fi

echo You are: ${username}

# Query IAM to get the user's MFA device
device=$(aws iam list-mfa-devices --user-name "${username}" --query 'MFADevices[*].SerialNumber' --output text)
if [ -z "${device}" ]; then
  echo "Can not find any MFA device for you."
  return
fi

if [ -z "$code" ]; then
  echo "Your MFA device is:" ${device}
  read -p "Enter your MFA code now: " code
fi

# Use the MFA device to get a session token and query out the necessary credentials.
output=$(aws sts get-session-token --serial-number "${device}" --query 'Credentials.[SecretAccessKey,AccessKeyId,SessionToken,Expiration]' --output text --token-code ${code})
secret=$(echo $output | cut -f1 -d ' ')
access=$(echo $output | cut -f2 -d ' ')
session=$(echo $output | cut -f3 -d ' ')
expiration=$(echo $output | cut -f4 -d ' ')

if [ -z "${secret}" -o -z "${session}" -o -z "${access}" ]; then
  echo "Unable to get temporary credentials."
  return
fi

# Seed the credentials into a new temp default profile in .aws/credentials
echo "[default]" > "${HOME}"/.aws/credentials
echo "aws_access_key_id = ${access}" >> "${HOME}"/.aws/credentials
echo "aws_secret_access_key = ${secret}" >> "${HOME}"/.aws/credentials
echo "aws_session_token = ${session}" >> "${HOME}"/.aws/credentials

echo "Keys are valid until ${expiration}"
echo "Temporary credentials have been stored in ${HOME}/.aws/credentials"

# Export the profile to use it by default
export AWS_PROFILE=default    
