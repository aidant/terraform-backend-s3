# Terraform Backend S3

## Quick Setup

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25.0"
    }
  }
}

module "backend_s3" {
  source = "github.com/aidant/terraform-backend-s3"
}
```
