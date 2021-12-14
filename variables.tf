variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "environment" {
  default = "odoo-dev"
}
variable "public_subnets_cidr" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "availability_zones" {
  default = ["us-east-2a", "us-east-2b"]
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "multi_az" {
  default = false
}

variable "database_name" {
  default = "odoo"
}

variable "database_username" {
  default = "odoo"
}

variable "database_password" {
  default = "secretpassword"
}