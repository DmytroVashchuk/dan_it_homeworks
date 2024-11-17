# modules/ec2_instance/main.tf

resource "aws_instance" "web" {
  ami             = "ami-089146c5626baa6bf" 
  instance_type   = "t3.micro"
  key_name        = "Dmytro"
  subnet_id       = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "Nginx Web Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo amazon-linux-extras install nginx1.12 -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              sudo systemctl status nginx
              EOF
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

