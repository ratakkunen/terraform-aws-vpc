module "db_subnet_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.environment_name}"
  subnet_ids = ["${aws_subnet.database.*.id}"]
  tags       = "${module.db_subnet_label.tags}"
}
