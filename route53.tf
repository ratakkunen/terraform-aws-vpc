resource "aws_route53_zone" "main" {
  name   = "${var.service_dns_zone_name}"

  tags {
    name         = "${var.namespace}-${var.environment_name}-route53-public-zone"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}
