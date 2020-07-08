/*
# tf_aws_module_name

A terraform module to describe a thing
*/

provider "aws" {
  region  = var.gv_aws_region
  version = "~> 2.68"
}

module "vpc" {
  source = "./modules/vpc"

  mvpc_project_name = var.gv_project_name
  mvpc_aws_ambiente = var.gv_aws_env
  mvpc_vpc_cidr     = var.gv_vpc_cidr
  mvpc_vpc_tenancy  = var.gv_vpc_tenancy

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

# module "computo" {
#   source = "./modules/computo"
#
#   mec2_project_name   = var.gv_project_name
#   mec2_aws_ambiente   = var.gv_aws_env
#   mec2_wordpress_ami  = var.gv_ec2_wordpress_ami
#   mec2_ami_size       = var.gv_ec2_ami_size
#   mec2_keyname        = var.gv_ec2_keyname
#   mec2_key_path       = var.gv_ec2_key_path
#   mec2_subnet_app_az1 = module.vpc.exp_subnet_app_az1_id
#   mec2_subnet_app_az2 = module.vpc.exp_subnet_app_az2_id
#   mec2_sg_public      = module.vpc.exp_sg_public_id
# }
