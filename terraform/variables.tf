variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "kulalearn"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  sensitive = true
}
