resource "aws_security_group" "rds_server" {
  vpc_id      = "${aws_vpc.main.id}"
  name_prefix = "${var.namespace}-${var.environment_name}-rds-server-"

  tags {
    Name         = "${var.namespace}-${var.environment_name}-rds-server"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}

resource "aws_security_group" "rds_client" {
  vpc_id      = "${aws_vpc.main.id}"
  name_prefix = "${var.namespace}-${var.environment_name}-rds-client-"

  tags {
    Name         = "${var.namespace}-${var.environment_name}-rds-client"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}

resource "aws_security_group_rule" "allow_from_client" {
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.rds_client.id}"
  security_group_id        = "${aws_security_group.rds_server.id}"
}

resource "aws_security_group_rule" "allow_to_server" {
  type                     = "egress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.rds_server.id}"
  security_group_id        = "${aws_security_group.rds_client.id}"
}
