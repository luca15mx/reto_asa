/*
# tf_aws_module_name

A terraform module to describe a thing
*/

provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  version = ">~ 1.6.0"
}


module "vpc" {
  source                = "./modules/vpc"
  aws_availability_zone = var.aws_availability_zone
  project_name          = var.project_name
}


# LLAMAR AL MODULO VPC

resource "aws_vpc" "vpc_asa" {
  cidr_block       = vars.cidr
  instance_tenancy = "${vars.vpc_tenancy}"

  tags = {
    Name = "VPC"
    Environment = "${vars.aws_env}"
  }
}