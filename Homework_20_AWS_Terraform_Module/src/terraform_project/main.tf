# main.tf

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr_block  = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
}

module "security_group" {
  source          = "./modules/security_group"
  vpc_id          = module.vpc.vpc_id
  list_of_open_ports = var.list_of_open_ports
}

module "ec2_instance" {
  source          = "./modules/ec2_instance"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.subnet_id
  security_group_id = module.security_group.security_group_id
  key_pair_name   = var.key_pair_name
}

