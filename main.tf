resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr_range}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    name         = "${var.namespace}-${var.environment_name}-main-vpc"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name         = "${var.domain_suffix}"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    name         = "${var.namespace}-${var.environment_name}-dhcp-options"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
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

  tags {
    name         = "${var.namespace}-${var.environment_name}-public-${var.availability_zones[count.index]}"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }

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

  tags {
    name         = "${var.namespace}-${var.environment_name}-private-${var.availability_zones[count.index]}"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }

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

  tags {
    name         = "${var.namespace}-${var.environment_name}-database-${var.availability_zones[count.index]}"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
