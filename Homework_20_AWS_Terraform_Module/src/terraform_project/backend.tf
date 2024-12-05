# backend.tf

terraform {
  backend "s3" {
    bucket = "terraform-state-danit-devops5"
    region = "eu-central-1"
    key    = "dmytrovashchuk/terraform.tfstate"
  }
}

