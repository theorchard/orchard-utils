# ecr-login

Logging into AWS ECR via Docker and the aws-cli allows us to pull down images of
our services and lambdas so we can run and inspect them locally.

## Requirements

- aws-cli (version 1 or 2)
- docker
- active AWS session credentials (see [the login script](../aws-creds-generator/))

## Usage

With the script installed in your PATH, run:

```sh
ecr-login
```

After the login, you can pull down and run images. Example:

```sh
docker pull 437795906767.dkr.ecr.us-east-1.amazonaws.com/ows-foobar:latest
docker run 437795906767.dkr.ecr.us-east-1.amazonaws.com/ows-foobar:latest
```
