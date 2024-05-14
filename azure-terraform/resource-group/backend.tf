# # Configure Terraform backend to use S3
# terraform {
#   backend "s3" {
#     bucket         = "s6-terraform-s3-backend"
#     key            = "azure-terraform/rg/terraform.tfstate" # state file name
#     region         = "us-east-1"
#     dynamodb_table = "s6-terraform-s3-lock" # optional, enables state locking with DynamoDB
#   }
# }