module "route_table_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${module.route_table_label.tags}"
}

# Private route table
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${module.route_table_label.tags}"
}

# Database route table
resource "aws_route_table" "database" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${module.route_table_label.tags}"
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
  tags   = "${module.route_table_label.tags}"
}

# IGW route for public route table
resource "aws_route" "igw_ipv4" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
  depends_on             = ["aws_route_table.public", "aws_internet_gateway.default"]
}

# Default route table, adopt it but dont do anything with it
resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"
}
