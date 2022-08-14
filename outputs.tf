output "bucket" {
  value       = aws_s3_bucket.terraform_state.id
  description = "The AWS S3 Bucket for the terraform backend."
}

output "dynamodb_endpoint" {
  value       = "dynamodb.${aws_s3_bucket.terraform_state.region}.amazonaws.com"
  description = "The DynamoDB Endpoint for the terraform backend."
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.terraform_state.name
  description = "The DynamoDB Endpoint for the terraform backend."
}

output "region" {
  value       = aws_s3_bucket.terraform_state.region
  description = "The AWS S3 Bucket Region for the terraform backend."
}

output "aws_iam_user" {
  value       = aws_iam_user.terraform_state.name
  description = "The IAM User with permissions for the terraform backend."
}

output "aws_access_key_id" {
  value       = aws_iam_access_key.terraform_state.id
  description = "The AWS Access Key Id with permissions for the terraform backend."
  sensitive   = true
}

output "aws_secret_access_key" {
  value       = aws_iam_access_key.terraform_state.secret
  description = "The AWS Secret Access Key with permissions for the terraform backend."
  sensitive   = true
}
