resource "aws_route53_zone" "main" {
  name   = "${var.service_dns_zone_name}"

  tags {
    Name         = "${var.namespace}-${var.environment_name}-route53-public-zone"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}

resource "aws_route53_zone" "private" {
  name          = "${var.private_service_dns_zone_name}"

  vpc {
    vpc_id    = "${var.vpc_id}"
  }

  tags {
    Name         = "${var.namespace}-${var.environment_name}-route53-private-zone"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
  force_destroy = true
}
