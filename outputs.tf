output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}

output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

output "database_subnets" {
  value = ["${aws_subnet.database.*.id}"]
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "aws_route53_zone_id" {
  value = "${aws_route53_zone.main.zone_id}"
}

output "aws_route53_zone_name" {
  value = "${aws_route53_zone.main.name}"
}

output "aws_route53_private_zone_id" {
  value = "${aws_route53_zone.private.zone_id}"
}

output "aws_route53_private_zone_name" {
  value = "${aws_route53_zone.private.name}"
}

output "public_route_table" {
  value = "${aws_route_table.public.id}"
}

output "private_route_table" {
  value = "${aws_route_table.private.id}"
}

output "database_route_table" {
  value = "${aws_route_table.database.id}"
}

output "rds_client_security_group" {
  value = "${aws_security_group.rds_client.id}"
}

output "rds_server_security_group" {
  value = "${aws_security_group.rds_server.id}"
}
