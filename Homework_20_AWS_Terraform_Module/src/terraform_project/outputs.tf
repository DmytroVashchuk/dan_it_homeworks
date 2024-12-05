# outputs.tf

output "instance_public_ip" {
  description = "The public IP of the created EC2 instance"
  value       = module.ec2_instance.public_ip
}

