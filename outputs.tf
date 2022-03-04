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

output "FRONTEND_ALB_ARN" {
  value = aws_lb.frontend-alb.arn
}

output "BACKEND_ALB_ARN" {
  value = aws_lb.backend-alb.arn
}