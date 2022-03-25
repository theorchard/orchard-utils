# aws-creds-generator

At The Orchard, we have Multi-factor Authentication (MFA) enforced for all IAM user accounts, and in order to use certain AWS services, we need confirm our identities whether using the console and/or using the AWS CLI, by logging in with an MFA token. The only thing the user needs to do is input an MFA token. The script will automatically generate temporary credentials that will last for 12 hours and provides the following:
```
 - AWS ACCESS KEY
 - AWS SECRET ACCESS KEY
 - AWS SESSION TOKEN
```

You need to have the following files present with your AWS credentials in them:
```
 - ~/.aws/credentials
 - ~/.aws/config
```

Your credentials file should have two profiles, one for our AWS Prod account, and another for the AWS Dev account. An example of how it should look:
```
[dev]
aws_access_key_id = foo
aws_secret_access_key = foo

[prod]
aws_access_key_id = boo
aws_secret_access_key = boo
```

Example use of this script:
```
. ./aws-session-login
```

You may supply an optional param for the profile name, rather than providing it interactively:
```
. ./aws-session-login prod
```

You may also supply an optional second param for the one-time auth token, rather than providing it interactively, e.g.:
```
. ./aws-session-login prod 123987
```

This script will create a new that will be stored as ```.store``` that will act as a master backup of your credentials. This will only be done if you're running this script for the first time. On subsequent uses of this script, it'll use that same ```.store``` file, and treat it the master source for your AWS credentials.

If you open a new terminal session, remember to run the following in order to use the temporary credentials:
```
export AWS_PROFILE=default
```

This script will manage:
 - Identifying your IAM user account by reading your credentials file in ~/.aws/credentials.
 - Finding which MFA device you have attached to your account.
 - Prompts for an MFA token. (Enter the token using the authenticator attached to your AWS account)
 - Creating a backup of ~/.aws/credentials and renamed to ~/.aws/.store.
 - Creating a new credentials file with a [default] profile that has the generated credentials.
 - Exporting the default profile in the same shell session where you ran the script.
