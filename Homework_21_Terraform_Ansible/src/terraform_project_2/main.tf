provider "aws" {
  region = "eu-north-1" 
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-north-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}



# EC2 інстанси
resource "aws_instance" "app" {
  count         = 2
  ami           = "ami-089146c5626baa6bf" 
  instance_type = "t3.micro"              
  key_name      = "Dmytro"
  
    subnet_id     = aws_subnet.public.id
  associate_public_ip_address = true             

  tags = {
    Name = "app-instance-${count.index + 1}"
  }
}

# Генерація інвентарного файлу для Ansible
resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.tpl", {
    public_ips = aws_instance.app[*].public_ip
  })
  filename = "${path.module}/inventory"
}






# Виведення публічних та приватних IP
output "public_ips" {
  value = aws_instance.app[*].public_ip
}

output "private_ips" {
  value = aws_instance.app[*].private_ip
}
