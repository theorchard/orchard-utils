# orchard-utils

A collection of generic helper utilities that are useful for, but not
limited to, developing against our technology stack.

---

## Utilities

- [AWS Session Login](./aws-creds-generator/)
- [ECR Login](./ecr-login/)

---

## Installation Using Brew (under development)

Requirements:

- python3
- aws cli (v1 or v2)
- brew

Run the following to add theorchard's brew formulas to your brew taps:

```sh
brew tap theorchard/theorchard
```

To install the utilities:

```sh
brew install orchard-utils --build-bottle
```

---

## Possible Improvements

- Complete brew install setup
- Add PR test job
- Automate releases
