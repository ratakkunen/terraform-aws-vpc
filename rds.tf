resource "aws_db_subnet_group" "main" {
  name       = "${var.environment_name}"
  subnet_ids = ["${aws_subnet.database.*.id}"]
}
