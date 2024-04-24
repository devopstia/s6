# Create S3 bucket
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "s6-terraform-s3-backend" # replace with your desired bucket 
}

# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.terraform_state_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}