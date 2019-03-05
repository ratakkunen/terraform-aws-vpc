# NAT Gateway
resource "aws_eip" "natgw" {
  vpc = true

  tags {
    Name         = "${var.namespace}-${var.environment_name}-natgw-eip"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}

resource "aws_nat_gateway" "default" {
  allocation_id = "${aws_eip.natgw.id}"
  subnet_id     = "${aws_subnet.public.0.id}"

  tags {
    Name         = "${var.namespace}-${var.environment_name}-natgw"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}

resource "aws_route" "natgw" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.default.id}"
  depends_on             = ["aws_route_table.private"]
}
