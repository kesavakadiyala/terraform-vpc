resource "aws_route_table" "public" {
  vpc_id            = aws_vpc.main.id
  route {
    cidr_block      = var.IGW_CIDR
    gateway_id      = aws_internet_gateway.igw.id
  }
  tags              = {
    Name            = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count             = length(aws_subnet.public_subnet.*.id)
  route_table_id    = aws_route_table.public.id
  subnet_id         = element(aws_subnet.public_subnet.*.id, count.index)
}

resource "aws_route_table" "private" {
  count             = length(aws_nat_gateway.ngw.*.id)
  vpc_id            = aws_vpc.main.id
  route {
    cidr_block      = var.IGW_CIDR
    gateway_id      = element(aws_nat_gateway.ngw.*.id, count.index)
  }
  tags              = {
    Name            = "Private-route-table${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count             = length(aws_route_table.private.*.id)
  route_table_id    = element(aws_route_table.private.*.id, count.index)
  subnet_id         = element(aws_subnet.private_subnet.*.id, count.index)
}