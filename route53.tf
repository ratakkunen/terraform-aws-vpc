module "route53_zone_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_route53_zone" "main" {
  name   = "${var.service_dns_zone_name}"
  tags   = "${module.route53_zone_label.tags}"
}
