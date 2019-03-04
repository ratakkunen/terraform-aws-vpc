resource "aws_route53_zone" "main" {
  name   = "${var.service_dns_zone_name}"
  tags   = "${module.label.tags}"
}
