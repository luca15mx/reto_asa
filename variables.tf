variable "aws_region" {
    default = "us_east-1"
}

variable "aws_secret_key" {
    default = ""
}

variable "aws_access_key"{
    default = ""
}

variable "vpc_tenancy"{    
    default = "dedicated"
}

variable "aws_env"{
    default = "Development"
}

variable "proyect_name"{    
    default = "Reto ASA"
}

# VARIABLES PARA NETWORKING

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
}

# Zona de disponibilidad 1

variable "public_subnet_az1" {
    default = "10.101.1.0/24" 
}

variable "app_subnet_az1" {
    default = "10.101.2.0/24" 
}

variable "db_subnet_az1" {
    default = "10.101.3.0/24" 
}

# Zona de disponibilidad 2

variable "public_subnet_az2" {
    default = "10.102.1.0/24" 
}

variable "app_subnet_az2" {
    default = "10.102.2.0/24" 
}

variable "db_subnet_az2" {
    default = "10.102.3.0/24" 
}

# VARIABLES PARA COMPUTO

variable "ec2_ami" {
    default = ""
}
