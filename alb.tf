resource "aws_lb" "frontend-alb-dev" {
  name               = "frontend-dev"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-frontend-alb.id]
  subnets            = aws_subnet.public_subnet.*.id
  tags = {
    Name        = "frontend-alb-dev"
  }
}

resource "aws_lb" "backend-alb-dev" {
  name               = "backend-alb-dev"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-backend-alb.id]
  subnets            = aws_subnet.private_subnet.*.id
  tags = {
    Name        = "backend-alb-dev"
  }
}

resource "aws_lb" "frontend-alb-prod" {
  name               = "frontend-prod"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-frontend-alb.id]
  subnets            = aws_subnet.public_subnet.*.id
  tags = {
    Name        = "frontend-alb-prod"
  }
}

resource "aws_lb" "backend-alb-prod" {
  name               = "backend-alb-prod"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-backend-alb.id]
  subnets            = aws_subnet.private_subnet.*.id
  tags = {
    Name        = "backend-alb-prod"
  }
}

resource "aws_route53_record" "backend-route53-dev" {
  count               = length(var.BACKEND_COMPONENTS)
  name                = "${element(var.BACKEND_COMPONENTS, count.index)}-dev"
  type                = "CNAME"
  zone_id             = var.HOSTED_ZONE_ID
  ttl                 = "300"
  records             = [aws_lb.backend-alb-dev.dns_name]
}

resource "aws_route53_record" "backend-route53-prod" {
  count               = length(var.BACKEND_COMPONENTS)
  name                = "${element(var.BACKEND_COMPONENTS, count.index)}-prod"
  type                = "CNAME"
  zone_id             = var.HOSTED_ZONE_ID
  ttl                 = "300"
  records             = [aws_lb.backend-alb-prod.dns_name]
}