resource "aws_lb" "frontend-alb-dev" {
  name               = "frontend-dev"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-frontend-alb.id]
  subnets            = aws_subnet.public_subnet.*.id
  tags = {
    Name        = "frontend-alb-dev"
    Environment = var.ENV
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
    Environment = var.ENV
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
    Environment = var.ENV
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
    Environment = var.ENV
  }
}

