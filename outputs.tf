output "VPC_ID" {
  value = aws_vpc.main.id
}

output "VPC_CIDR" {
  value = aws_vpc.main.cidr_block
}

output "PRIVATE_SUBNET" {
  value = aws_subnet.private_subnet.*.id
}

output "PUBLIC_SUBNET" {
  value = aws_subnet.public_subnet.*.id
}

output "PRIVATE_CIDR" {
  value = aws_subnet.private_subnet.*.cidr_block
}

output "PUBLIC_CIDR" {
  value = aws_subnet.public_subnet.*.cidr_block
}

output "HOSTED_ZONE_ID" {
  value = var.HOSTED_ZONE_ID
}

output "FRONTEND_ALB_ARN_DEV" {
  value = aws_lb.frontend-alb-dev.arn
}

output "BACKEND_ALB_ARN_DEV" {
  value = aws_lb.backend-alb-dev.arn
}

output "FRONTEND_ALB_ARN_PROD" {
  value = aws_lb.frontend-alb-prod.arn
}

output "BACKEND_ALB_ARN_PROD" {
  value = aws_lb.backend-alb-prod.arn
}