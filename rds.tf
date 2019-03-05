resource "aws_db_subnet_group" "main" {
  name       = "${var.environment_name}"
  subnet_ids = ["${aws_subnet.database.*.id}"]

  tags {
    Name         = "${var.namespace}-${var.environment_name}-db-subnet-group"
    Namespace    = "${var.namespace}"
    Stage        = "${var.environment_name}"
  }
}
