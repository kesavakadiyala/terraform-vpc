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

resource "aws_route53_record" "backend-route53-dev" {
  count               = length(var.BACKEND_COMPONENTS) == 5 && var.ENV == "dev" ? 5 : 0
  name                = "${element(var.BACKEND_COMPONENTS, count.index)}-${var.ENV}"
  type                = "CNAME"
  zone_id             = var.HOSTED_ZONE_ID
  ttl                 = "300"
  records             = [aws_lb.backend-alb-dev.dns_name]
}

resource "aws_route53_record" "backend-route53-prod" {
  count               = length(var.BACKEND_COMPONENTS) == 5 && var.ENV == "prod" ? 5 : 0
  name                = "${element(var.BACKEND_COMPONENTS, count.index)}-${var.ENV}"
  type                = "CNAME"
  zone_id             = var.HOSTED_ZONE_ID
  ttl                 = "300"
  records             = [aws_lb.backend-alb-prod.dns_name]
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
