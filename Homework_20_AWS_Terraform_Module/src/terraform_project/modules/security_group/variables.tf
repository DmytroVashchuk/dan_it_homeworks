# modules/security_group/variables.tf

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of open ports for the security group"
  type        = list(number)
  default     = [80, 22]
}

