terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.25.0"
    }
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state" {
  name         = aws_s3_bucket.terraform_state.id
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_iam_policy_document" "terraform_state" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.terraform_state.arn]
  }
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.terraform_state.arn}/*"]
  }
  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.terraform_state.arn]
  }
}

resource "aws_iam_user_policy" "terraform_state" {
  name = aws_s3_bucket.terraform_state.id
  user = aws_iam_user.terraform_state.name

  policy = data.aws_iam_policy_document.terraform_state.json
}

resource "aws_iam_user" "terraform_state" {
  name = aws_s3_bucket.terraform_state.id
}

resource "aws_iam_access_key" "terraform_state" {
  user = aws_iam_user.terraform_state.name
}
