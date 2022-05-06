# aws-session-login

In order for AWS users with Multi-Factor Authentication turned on to use certain AWS services, we need to log in with an MFA token. The script will walk you through generating temporary credentials that will last for 12 hours and provides an **AWS ACCESS KEY**, **AWS SECRET ACCESS KEY**, and **AWS SESSION TOKEN**

This script will manage:

- Identifying your IAM user account by reading your credentials file in ~/.aws/credentials.
- Finding which MFA device you have attached to your account.
- Prompts for an MFA token. (Enter the token using the authenticator attached to your AWS account)
- Creating or replacing the file `~/.aws/{profile name}.session.env` containing the session credentials.

## Prerequisites

- [aws-cli](https://aws.amazon.com/cli/) (version 1 or 2, configured by running `aws configure`)

Once configured, your credentials file should have one or more profiles, e.g. a file with a **default** and **prod** profile:

```text
[default]
aws_access_key_id = foo
aws_secret_access_key = foo

[prod]
aws_access_key_id = boo
aws_secret_access_key = boo
```

## Usage

```sh
$ aws-session-login

Select an AWS profile:
1) default
2) dev
3) prod
4) service
5) snowflake
-------------
# You can enter the number or name of the profile you want to login as
Enter profile number:

Profile found for:    myUserName
Your MFA device is:   arn:aws:iam::437795906767:mfa/myUserName
# You will be prompted to enter your MFA code
MFA code:

Copy the following:
# expires: 2022-05-07T03:47:44+00:00
export AWS_ACCESS_KEY_ID={key id}
export AWS_SECRET_ACCESS_KEY={access key}
export AWS_SESSION_TOKEN={token}
export AWS_DEFAULT_REGION={region}
```

You may optionally specify the profile name when running the command, e.g. `aws-session-login prod`

Once the script has run, you can load the session credentials into your current shell by running the following command, where `{profile name}` is replaced with the profile you generated credentials for. If you open a new terminal session, remember to rerun this command:

```sh
. ~/.aws/{profile name}.session.env
```

You can reuse the credentials in this file until the expiration time has reached.
