# Define our VPC
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# ###########################################################################################
##  AZ1
# ###########################################################################################

# Define the public subnet
resource "aws_subnet" "public_subnet_az1" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr_az1}"
  availability_zone = "${var.aws_availability_zone_az1}"

  tags = {
    Name = "Public Subnet AZ1 ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# Private subnet

## APP

resource "aws_subnet" "subnet_app_az1" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.app_subnet_cidr_az1}"
  availability_zone = "${var.aws_availability_zone_az1}"

  tags = {
    Name = "APP Subnet AZ1 ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

## DB

resource "aws_subnet" "subnet_db_az1" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.db_subnet_cidr_az1}"
  availability_zone = "${var.aws_availability_zone_az1}"

  tags = {
    Name = "APP Subnet AZ1 ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# ###########################################################################################
##  AZ2
# ###########################################################################################

# Public subnet AZ2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr_az2}"
  availability_zone = "${var.aws_availability_zone_az2}"

  tags = {
    Name = "Public Subnet az2 ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# Private subnet AZ2

## APP

resource "aws_subnet" "subnet_app_az2" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.app_subnet_cidr_az2}"
  availability_zone = "${var.aws_availability_zone_az2}"

  tags = {
    Name = "APP Subnet az2 ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

## DB AZ2

resource "aws_subnet" "subnet_db_az2" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.db_subnet_cidr_az2}"
  availability_zone = "${var.aws_availability_zone_az2}"

  tags = {
    Name = "APP Subnet az2 ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# ###########################################################################################
# Internet gateway
# ###########################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.default.id}"

  tags = {
    Name = "VPC IGW ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# ###########################################################################################
# Define the route table
# ###########################################################################################
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "RT ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# ###########################################################################################
# Assign the route table to the public Subnet
# ###########################################################################################
resource "aws_route_table_association" "public_rt" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

# ###########################################################################################
# Define the security group for public subnet
# ###########################################################################################
resource "aws_security_group" "sg_public" {
  name        = "${var.project_name}-${var.vpc_sg_public_name}"
  description = "Permite trafico de entrada HTTP y SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # Postgres DB
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr_az1}"]
  }

  egress { # SSH
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr_az1}"]
  }

  egress { # Todo el tráfico
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.public_subnet_cidr_az1}"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags = {
    Name = "SG Publico ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

# ###########################################################################################
# Define the security group for private subnet
# ###########################################################################################
resource "aws_security_group" "sg_private" {
  name        = "${var.project_name}-${var.vpc_sg_private_name}"
  description = "Allow traffic from public subnet"

  ingress { # Postgres
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr_az1]
  }

  ingress { # Todo el tráfico
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.public_subnet_cidr_az1]
  }

  ingress { # Conexiones SSH
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr_az1]
  }

  vpc_id = aws_vpc.default.id

  tags = {
    Name = "SG Privado ${vars.project_name}"
    Environment = "${vars.aws_ambiente}"
  }
}

################################################################################
##
##  SECCION DE EXPORTACION DE VARIABLES PARA USO EN OTRO MODULO
##
################################################################################

output "vpc_identification" {
  value = "${aws_vpc.default.id}"
}

################################################################################

output "exp_subnet_publica_az1_id" {
  value = "${aws_subnet.public_subnet_az1.id}"
}


output "exp_subnet_app_az1_id" {
  value = "${aws_subnet.subnet_app_az1.id}"
}

output "exp_subnet_db_az1_id" {
  value = "${aws_subnet.subnet_db_az1.id}"
}

################################################################################

output "exp_subnet_publica_az2_id" {
  value = "${aws_subnet.public_subnet_az1.id}"
}


output "exp_subnet_app_az2_id" {
  value = "${aws_subnet.subnet_app_az1.id}"
}

output "exp_subnet_db_az2_id" {
  value = "${aws_subnet.subnet_db_az1.id}"
}

################################################################################

output "exp_igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}


################################################################################

output "exp_public_rt_id" {
  value = "${aws_route_table.public_rt.id}"
}

################################################################################

output "exp_sg_public_id" {
  value = "${aws_security_group.sg_public.id}"
}

output "exp_sg_private_id" {
  value = "${aws_security_group.sg_private.id}"
}
