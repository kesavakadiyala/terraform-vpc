resource "aws_security_group" "allow-frontend-alb" {
  name        = "allow-frontend-alb"
  description = "allow-frontend-alb"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-frontend-alb"
  }
}

resource "aws_security_group" "allow-backend-alb" {
  name        = "allow-backend-alb"
  description = "allow-backend-alb"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet.*.cidr_block[0], aws_subnet.private_subnet.*.cidr_block[1]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-backend-alb"
  }
}



resource "aws_security_group" "allow-ssh-for-bastion" {
  name        = "Allow-ssh-for-bastion"
  description = "Allow-ssh-for-bastion"
  vpc_id = aws_vpc.main.id
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow-ssh-for-bastion"
  }
}