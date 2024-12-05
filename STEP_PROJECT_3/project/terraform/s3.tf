resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = "my-terraform-state-bucket-unique-67890"

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_public_access" {
  bucket                  = "my-terraform-state-bucket-unique-67890"
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "terraform_state_policy" {
  bucket = "my-terraform-state-bucket-unique-67890"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowRootUserAccess"
        Effect    = "Allow"
        Principal = { "AWS" : "arn:aws:iam::746669199028:user/dimonchik06@gmail.com" }
        Action    = "s3:*"
        Resource  = [
          "arn:aws:s3:::my-terraform-state-bucket-unique-67890",
          "arn:aws:s3:::my-terraform-state-bucket-unique-67890/*"
        ]
      }
    ]
  })
}
