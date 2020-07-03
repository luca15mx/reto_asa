variable "gv_project_name" {
  default = "ASA "
}

variable "gv_aws_region" {
  default = "us-east-1"
}

variable "gv_aws_secret_key" {
  default = ""
}

variable "gv_aws_access_key" {
  default = ""
}

variable "gv_vpc_tenancy" {
  default = "dedicated"
}

variable "gv_aws_env" {
  default = "Development"
}

variable "gv_proyect_name" {
  default = "Reto ASA"
}

# VARIABLES PARA NETWORKING

variable "gv_vpc_cidr" {
  default = "10.101.0.0/16"
}

# Zona de disponibilidad 1

variable "gv_az1" {
  default = "us-east-1a"
}

variable "gv_public_subnet_cdir_az1" {
  default = "10.101.1.0/24"
}

variable "gv_app_subnet_cdir_az1" {
  default = "10.101.2.0/24"
}

variable "gv_db_subnet_cdir_az1" {
  default = "10.101.3.0/24"
}

# Zona de disponibilidad 2

variable "gv_az2" {
  default = "us-east-1b"
}


variable "gv_public_subnet_cdir_az2" {
  default = "10.101.4.0/24"
}

variable "gv_app_subnet_cdir_az2" {
  default = "10.101.5.0/24"
}

variable "gv_db_subnet_cdir_az2" {
  default = "10.101.6.0/24"
}

# VARIABLES PARA COMPUTO

variable "gv_ec2_ami" {
  default = ""
}
