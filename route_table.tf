# Public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    name         = "${var.namespace}-${var.environment_name}-public-route-table"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}

# Private route table
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    name         = "${var.namespace}-${var.environment_name}-private-route-table"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}

# Database route table
resource "aws_route_table" "database" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    name         = "${var.namespace}-${var.environment_name}-database-route-table"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}

# Public route table association
resource "aws_route_table_association" "public" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

# Private route table association
resource "aws_route_table_association" "private" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.id}"
}

# Database route table association
resource "aws_route_table_association" "database" {
  count          = "2"
  subnet_id      = "${aws_subnet.database.*.id[count.index]}"
  route_table_id = "${aws_route_table.database.id}"
}

# VPC default route table
resource "aws_main_route_table_association" "default" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.private.id}"
}

# Internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    name         = "${var.namespace}-${var.environment_name}-internet-gateway"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}

# IGW route for public route table
resource "aws_route" "igw_ipv4" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
  depends_on             = ["aws_route_table.public", "aws_internet_gateway.default"]
}
