provider "aws" {
  region = var.region
}

resource "aws_key_pair" "default" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_${random_id.suffix.hex}"
  description = "Allow SSH inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Port 3000 (e.g. frontend)"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Port 9090 (e.g. Prometheus)"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "devops-instance"
  }
}
