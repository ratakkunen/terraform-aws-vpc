module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr_range}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = "${module.label.tags}"
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "${var.domain_suffix}"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags                = "${module.label.tags}"
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.main.id}"
}

# Public subnets
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(var.availability_zones)}"
  cidr_block              = "${element(var.public_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true
  tags                    = "${module.label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

# Private subnets
resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(var.availability_zones)}"
  cidr_block              = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false
  tags                    = "${module.label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

# Database subnets
resource "aws_subnet" "database" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(var.availability_zones)}"
  cidr_block              = "${element(var.database_subnet_cidrs, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false
  tags                    = "${module.label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}
