# Jenkins Master (Public Subnet)
resource "aws_instance" "jenkins_master" {
  ami           = "ami-0ed6534c7d6a8e78f" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "MyKeyPair"  # Ваш ключ SSH
  security_groups = [aws_security_group.jenkins_sg.id]
  
  user_data = file("user_data/jenkins_master.sh")

  tags = {
    Name = "Jenkins Master"
  }
}

# Jenkins Worker (Private Subnet)
resource "aws_instance" "jenkins_worker" {
  ami           = "ami-0ed6534c7d6a8e78f" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  key_name      = "MyKeyPair"  # Ваш ключ SSH
  security_groups = [aws_security_group.jenkins_sg.id]

  user_data = file("user_data/jenkins_worker.sh")

  tags = {
    Name = "Jenkins Worker"
  }
}

# Security Group для Jenkins
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and HTTP access for Jenkins"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Дозволити SSH між Master і Worker
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["10.0.1.0/24"] # Підмережа Jenkins Master
}

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
