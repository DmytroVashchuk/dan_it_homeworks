# variables.tf

variable "aws_region" {
  description = "AWS region for deployment"
  default     = "eu-north-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "list_of_open_ports" {
  description = "List of open ports for the security group"
  type        = list(number)
  default     = [80, 22]
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "key_pair_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "MyKeyPair"
}

