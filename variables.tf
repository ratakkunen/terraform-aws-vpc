variable "vpc_cidr_range" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "public_subnet_cidrs" {
  type = "list"
}

variable "private_subnet_cidrs" {
  type = "list"
}

variable "database_subnet_cidrs" {
  type = "list"
}

variable "environment_name" {
  type = "string"
}

variable "service_dns_zone_name" {
  type = "string"
}

variable "domain_suffix" {
  type = "string"
}
