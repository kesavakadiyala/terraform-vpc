resource "aws_internet_gateway" "igw" {
  vpc_id            = aws_vpc.main.id
  tags              = {
    Name            = "InternetGateWay-${var.ENV}"
    Environment     = var.ENV
  }
}

resource "aws_eip" "nat" {
  count             = length(aws_subnet.public_subnet.*.id)
  vpc               = true
}

resource "aws_nat_gateway" "ngw" {
  count             = length(aws_subnet.public_subnet.*.id)
  allocation_id     = element(aws_eip.nat.*.id, count.index)
  subnet_id         = element(aws_subnet.public_subnet.*.id, count.index)
  tags              = {
    Name            = "Nat-Gateway${count.index}"
    Environment     = var.ENV
  }
}
