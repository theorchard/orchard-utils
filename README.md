# orchard-utils

Utilities to help automate common tasks when developing against our technology stack.

---

## Utilities

- [AWS Session Login](./aws-creds-generator) - Generate session credentials for AWS using MFA
- [ECR Login](./ecr-login) - Log into ECR to enable pulling/pushing docker images

---

## Installation Using Brew

Run the following command to add The Orchard's brew formulas to your brew taps:

```sh
brew tap theorchard/theorchard
```

To install the utilities:

```sh
brew install orchard-utils --build-bottle
```

That's it! Now each utility should be available in the command line by typing its name. For example `$ aws-sessions-login`.

---

## Contributing

Everyone is encouraged to their own utilities or improvements to existing utilities. You can create a PR by following these guidelines:

- New utilities should automate common tasks that engineers perform
- Utilities should be fully documented, and offer clear instructions to users.
- This is an open source project, so code shouldn't refer to specific orchard resources
- Updates must be tested against multiple environments, including `bash` and `zsh` on intel and m1 processors
- `shellcheck` linting should be run against PRs

## Possible Improvements

- Add PR test job
- Automate releases
