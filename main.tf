/*
# tf_aws_module_name

A terraform module to describe a thing
*/

provider "aws" {
  region = var.gv_aws_region
  #access_key = var.gv_aws_access_key
  #secret_key = var.gv_aws_secret_key
  version = "~> 2.68"
}

module "vpc" {
  source = "./modules/vpc"

  mvpc_project_name = var.gv_project_name
  mvpc_aws_ambiente = var.gv_aws_env
  mvpc_vpc_cidr     = var.gv_vpc_cidr

  #  Subredes AZ1
  mvpc_aws_availability_zone_az1 = var.gv_az1
  mvpc_public_subnet_cidr_az1    = var.gv_public_subnet_cdir_az1
  mvpc_app_subnet_cidr_az1       = var.gv_app_subnet_cdir_az1
  mvpc_db_subnet_cdir_az1        = var.gv_db_subnet_cdir_az1

  #  Subredes AZ2
  mvpc_aws_availability_zone_az2 = var.gv_az2
  mvpc_public_subnet_cidr_az2    = var.gv_public_subnet_cdir_az2
  mvpc_app_subnet_cidr_az2       = var.gv_app_subnet_cdir_az2
  mvpc_db_subnet_cdir_az2        = var.gv_db_subnet_cdir_az2
}
