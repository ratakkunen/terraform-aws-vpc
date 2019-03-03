# NAT Gateway
resource "aws_eip" "natgw" {
  vpc = true

  tags = {
    Name = "NAT Gateway"
  }
}

resource "aws_nat_gateway" "default" {
  allocation_id = "${aws_eip.natgw.id}"
  subnet_id     = "${aws_subnet.public.0.id}"
}

resource "aws_route" "natgw" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.default.id}"
  depends_on             = ["aws_route_table.private"]
}
