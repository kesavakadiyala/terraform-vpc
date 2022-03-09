resource "aws_vpc" "main" {
  cidr_block         = var.VPC_CIDR
  tags               = {
    Name             = "Roboshop_VPC-${var.ENV}"
    Environment      = var.ENV
  }
}

resource "aws_subnet" "public_subnet" {
  count              = length(var.PUBLIC_CIDR)
  cidr_block         = element(var.PUBLIC_CIDR, count.index)
  vpc_id             = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  availability_zone  = element(data.aws_availability_zones.available.names, count.index)
  tags               = {
    Name             = "Public-Subnet${count.index+1}"
    Environment      = var.ENV
  }
}

resource "aws_subnet" "private_subnet" {
  count              = length(var.PRIVATE_CIDR)
  cidr_block         = element(var.PRIVATE_CIDR, count.index)
  vpc_id             = aws_vpc.main.id
  availability_zone  = element(data.aws_availability_zones.available.names, count.index)
  tags               = {
    Name             = "Private-Subnet${count.index+1}"
    Environment      = var.ENV
  }
}

//Creating instance for Bastion
resource "aws_instance" "bastion-instance" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.medium"
  vpc_security_group_ids = [aws_security_group.allow-ssh-for-bastion.id]
  subnet_id = aws_subnet.public_subnet[0].id
  tags = {
    Name = "bastion-instance"
  }
}
