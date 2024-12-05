variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  default     = "my-terraform-state-bucket-unique-67890"
}

variable "environment" {
  description = "Environment (e.g., dev, prod)"
  default     = "dev"
}
