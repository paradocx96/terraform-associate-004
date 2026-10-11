# Lab 06 (Optional) — AWS Provider, Data Sources, `dynamic`, Import and Remote State

**Objectives:** 2a–2c, 4a, 4e, 4f, 6b, 6c, 7a · **Needs:** an AWS account + credentials

> **Cost & safety:** this lab uses an S3 bucket and a security group, which cost almost nothing, but always run `terraform destroy` at the end and set an AWS budget alert. Never commit credentials. Use an IAM user/role with least privilege, or SSO, and set credentials via environment variables or `aws configure` — **not in `.tf` files**.
>
> Skip this lab if you don't want an AWS account — the exam does not require cloud knowledge. Redo Lab 05 with extra scenarios instead.

## Part 1 — Provider, data sources, resources

1. Configure credentials (`export AWS_PROFILE=...` or `aws sso login`).
2. `terraform init` (note the AWS provider version chosen and the lock file).
3. `terraform plan` → identify implicit dependencies (bucket → versioning) and `data` reads.
4. `terraform apply`. In the AWS console, find the bucket and security group.
5. Add a port to `ingress_ports` and watch the `dynamic` block change the plan.

## Part 2 — Multiple provider configurations

Add an aliased provider and a second bucket in another region:

```hcl
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_s3_bucket" "west" {
  provider = aws.west
  bucket   = "tf-assoc-demo-west-${random_id.suffix.hex}"
}
```

## Part 3 — Import an existing bucket

1. Create a bucket outside Terraform:
   `aws s3api create-bucket --bucket my-import-demo-<unique> --region us-east-1`
   (other regions need `--create-bucket-configuration LocationConstraint=<region>`)
2. Add an import block to a new file `import.tf`:

```hcl
import {
  to = aws_s3_bucket.imported
  id = "my-import-demo-<unique>"
}
```

3. `terraform plan -generate-config-out=generated.tf` → review the generated resource block.
4. Move/clean the generated block into your configuration, `terraform plan`, then `terraform apply`.
5. Compare with the legacy CLI command `terraform import` (state only, no config generation).

## Part 4 — Remote state in S3 with locking

1. Create a separate state bucket manually (versioning enabled) — name it e.g. `my-tf-state-<unique>`.
2. Add:

```hcl
terraform {
  backend "s3" {
    bucket       = "my-tf-state-<unique>"
    key          = "lab06/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # native locking; older setups use DynamoDB. Check current docs.
  }
}
```

3. `terraform init -migrate-state`. Confirm the state object appears in S3 and `terraform.tfstate` is no longer local.
4. Try to put variables in the backend block and observe the error (backend blocks can't use variables). Use `-backend-config` for partial configuration instead.

## Clean up

```bash
terraform destroy
aws s3 rb s3://my-import-demo-<unique> --force   # if you did not import/destroy it
aws s3 rb s3://my-tf-state-<unique> --force
```

## Check yourself

- [ ] I can use an aliased provider.
- [ ] I can explain implicit dependencies in this config.
- [ ] I can import with an `import` block and generate configuration.
- [ ] I can migrate local state to a remote backend.
