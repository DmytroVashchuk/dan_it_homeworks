# modules/security_group/main.tf

resource "aws_security_group" "allow_ports" {
  name        = "allow_ports"
  description = "Allow open ports from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.list_of_open_ports[0]
    to_port     = var.list_of_open_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.list_of_open_ports[1]
    to_port     = var.list_of_open_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
  from_port   = -1  
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.allow_ports.id
}