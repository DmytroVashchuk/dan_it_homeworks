provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-unique-67890"
    key            = "terraform/state"
    region         = "us-east-1"
    
    encrypt        = true
  }
}
