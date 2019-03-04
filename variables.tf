variable "namespace" {
  description = "Namespace (e.g. `idsgrp` or `ids`)"
  type        = "string"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = "string"
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

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
