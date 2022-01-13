#!/usr/bin/env bash

if [[ -z "$GITHUB_USER" ]]; then
    echo "GITHUB_USER env var not set"
    exit 1
fi
if [[ -z "$GITHUB_ACCESS_TOKEN" ]]; then
    echo "GITHUB_ACCESS_TOKEN env var not set"
    exit 1
fi

TERRAFORM_MODULES=(
    "terraform-airflow",
    "terraform-aws-waf"
    "terraform-chef-bootstrap"
    "terraform-datadog"
    "terraform-dynamodb"
    "terraform-efs"
    "terraform-elasticache",
    "terraform-elasticsearch"
    "terraform-emr"
    "terraform-fargate"
    "terraform-github"
    "terraform-jenkins"
    "terraform-kinesis"
    "terraform-lambda"
    "terraform-managed-kafka"
    "terraform-owsrequest"
    "terraform-rds"
    "terraform-s3"
    "terraform-secrets-manager"
    "terraform-sentry"
    "terraform-sftp"
    "terraform-sns"
    "terraform-sqs"
    "terraform-transit-gateway"
    "terraform-vmware"
    "terraform-vpc"
)

for MODULE_NAME in "${TERRAFORM_MODULES[@]}"; do
    LATEST_VERSION_RAW=$(
        curl -s -u "${GITHUB_USER}:${GITHUB_ACCESS_TOKEN}" "https://api.github.com/repos/theorchard/${MODULE_NAME}/releases/latest" -H "Accept: application/vnd.github.v4.full+json" | \
            grep '"tag_name":' | tr -d " " | tr -d '"' | tr -d ","
    )
    LATEST_VERSION=${LATEST_VERSION_RAW##tag_name:}
    echo "${MODULE_NAME}:${LATEST_VERSION}"
done
