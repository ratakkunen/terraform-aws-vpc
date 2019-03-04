resource "aws_db_subnet_group" "main" {
  name       = "${var.environment_name}"
  subnet_ids = ["${aws_subnet.database.*.id}"]

  tags {
    name         = "${var.namespace}-${var.environment_name}-db-subnet-group"
    namespace    = "${var.namespace}"
    stage        = "${var.environment_name}"
  }
}
