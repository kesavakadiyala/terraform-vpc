resource "aws_lb" "frontend-alb" {
  name               = "frontend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-frontend-alb.id]
  subnets            = aws_subnet.public_subnet.*.id
  tags = {
    Name        = "frontend-alb"
    Environment = var.ENV
  }
}

resource "aws_lb" "backend-alb" {
  name               = "backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-backend-alb.id]
  subnets            = aws_subnet.private_subnet.*.id
  tags = {
    Name        = "backend-alb"
    Environment = var.ENV
  }
}
