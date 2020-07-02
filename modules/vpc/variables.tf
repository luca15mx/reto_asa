# Variables para Modulo VPC

variable "project_name" {}

variable "aws_ambiente" {}

variable "vpc_cidr" {
  # description = "CIDR for the VPC"
  # default     = "10.0.0.0/16"
}

# ###########################################################################################

#  Subredes AZ1

# ###########################################################################################

variable "aws_availability_zone_az1" {}

variable "public_subnet_cidr_az1" {
  # description = "CIDR for the public subnet"
  # default     = "10.0.1.0/24"
}

variable "sg_public_az1" {
  default = "sg_public"
}

variable "app_subnet_cidr_az1" {
  # description = "CIDR for the private subnet"
  # default     = "10.0.2.0/24"
}

variable "sg_app_az1" {
  default = "sg_public"
}

variable "db_subnet_cdir_az1" {
}

variable "sg_db_az1" {
  default = "sg_public"
}

# ###########################################################################################

#  Subredes AZ2

# ###########################################################################################

variable "aws_availability_zone_az2" {}

variable "public_subnet_cidr_az2" {
  # description = "CIDR for the public subnet"
  # default     = "10.0.1.0/24"
}

variable "sg_public_az2" {
  default = "sg_public"
}

variable "app_subnet_cidr_az2" {
  # description = "CIDR for the private subnet"
  # default     = "10.0.2.0/24"
}

variable "sg_app_az2" {
  default = "sg_public"
}

variable "db_subnet_cdir_az2" {

}

variable "sg_db_az2" {
  default = "sg_public"
}
