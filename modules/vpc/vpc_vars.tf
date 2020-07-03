# Variables para Modulo VPC

variable "mvpc_project_name" {}

variable "mvpc_aws_ambiente" {}

variable "mvpc_vpc_cidr" {}

variable "mvpc_vpc_tenancy" {}

# ###########################################################################################

#  Subredes AZ1

# ###########################################################################################

variable "mvpc_aws_availability_zone_az1" {}

variable "mvpc_public_subnet_cidr_az1" {}

variable "mvpc_app_subnet_cidr_az1" {}

variable "mvpc_db_subnet_cdir_az1" {}


# ###########################################################################################

#  Subredes AZ2

# ###########################################################################################

variable "mvpc_aws_availability_zone_az2" {}

variable "mvpc_public_subnet_cidr_az2" {}

variable "mvpc_app_subnet_cidr_az2" {}

variable "mvpc_db_subnet_cdir_az2" {}
