resource "aws_route53_zone" "main" {
  name   = "${var.service_dns_zone_name}"

  tags {
    Name         = "${var.namespace}-${var.environment_name}-route53-public-zone"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}
