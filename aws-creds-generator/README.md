# aws-session-login

In order for AWS users with Multi-Factor Authentication turned on to use certain AWS services, we need to log in with an MFA token. The script will walk you through generating temporary credentials that will last for 12 hours and provides an **AWS ACCESS KEY**, **AWS SECRET ACCESS KEY**, and **AWS SESSION TOKEN**

## Prerequisites

- [aws-cli](https://aws.amazon.com/cli/) (version 1 or 2, configured by running `aws configure`)

## Usage

```sh
aws-session-login [-j] [profileName] [mfaCode]

examples:
aws-session-login
aws-session-login default
aws-session-login prod 512382
aws-session-login -j dev
```

`profileName` and `mfaCode` are optional parameters that the script will prompt you for if not included in the command call.

The `-j` flag (Jerry's Script Mode) will move your `~/.aws/credentials` to `~/.aws/.store` and overwrite the `credentials`
file with your temporary session creds. If this option is omitted, your `credentials` file will not be altered and
the generated session credentials will be written to a file named after the selected profile: `~/.aws/{profileName}.session.env`.

You can generate multiple profile session credentials through subsequent calls to this command and all will remain valid until
their expiration time.

When not using the `-j` flag, you will need to add the session credentials to your env in any terminal/shell you wish to
use the session credentials in. This can be accomplished via the command `. ~/.aws/{profileName}.session.env` where
`profileName` is the name of the profile you used to generate the creds (note the `.` preceding the path to the creds file)
