
resource "aws_key_pair" "default" {
  key_name   = var.mec2_keyname
  public_key = file(var.mec2_key_path)
}

################################################################################
#  EC2 en la primer zona de dispoibilidad
################################################################################

resource "aws_instance" "wp_az1" {
  ami           = var.mec2_wordpress_ami
  instance_type = var.mec2_ami_size
  subnet_id     = var.mec2_sg_app_az1

  associate_public_ip_address = true
  key_name                    = aws_key_pair.default.id
  #user_data                   = file("../scripts/install.sh")

  tags = {
    Name        = "EC2 WPess AZ1 ${var.mec2_project_name}"
    Environment = var.mec2_aws_ambiente
  }
}


################################################################################
#  EC2 en la segunda zona de dispoibilidad
################################################################################

resource "aws_instance" "wp_az2" {
  ami                         = var.mec2_wordpress_ami
  instance_type               = var.mec2_ami_size
  subnet_id                   = var.mec2_sg_app_az2
  associate_public_ip_address = true
  key_name                    = aws_key_pair.default.id
  #user_data                   = file("../scripts/install.sh")

  tags = {
    Name        = "EC2 WPess AZ2 ${var.mec2_project_name}"
    Environment = var.mec2_aws_ambiente
  }
}
