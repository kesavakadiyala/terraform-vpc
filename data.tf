data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ami" {
  owners           = ["342998638422"]
  most_recent      = true
  name_regex       = "^Centos7-Kesava"
}
