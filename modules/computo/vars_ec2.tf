variable "mec2_aws_ambiente" {}

variable "mec2_project_name" {}

variable "mec2_wordpress_ami" {}

variable "mec2_ami_size" {}

variable "mec2_keyname" {}

variable "mec2_key_path" {}

variable "mec2_sg_app_az1" {
  default = ""
}

variable "mec2_sg_app_az2" {
  default = ""
}

variable "mec2_sg_public" {}

variable "mec2_subnet_app_az1" {}

variable "mec2_subnet_app_az2" {}
