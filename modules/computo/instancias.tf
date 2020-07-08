# TODO:
# Crear los sg para los wordpress
# Verificar el error de permiso de la creación del bucket
# Verificar el uso de depends on

resource "aws_key_pair" "default" {
  key_name   = var.mec2_keyname
  public_key = file(var.mec2_key_path)
}

################################################################################
#  EC2 en la primer zona de dispoibilidad
################################################################################

resource "aws_instance" "wp_az1" {
  ami                         = var.mec2_wordpress_ami
  instance_type               = var.mec2_ami_size
  subnet_id                   = var.mec2_subnet_app_az1
  vpc_security_group_ids      = ["${var.mec2_sg_public}"]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.default.id
  #user_data                   = file("../scripts/install.sh")

  ebs_block_device {
    device_name           = "/dev/sdh"
    encrypted             = false
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }

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
  subnet_id                   = var.mec2_subnet_app_az2
  vpc_security_group_ids      = ["${var.mec2_sg_public}"]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.default.id
  #user_data                   = file("../scripts/install.sh")

  ebs_block_device {
    device_name           = "/dev/sdh"
    encrypted             = false
    volume_type           = "standard"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    Name        = "EC2 WPess AZ2 ${var.mec2_project_name}"
    Environment = var.mec2_aws_ambiente
  }
}

################################################################################
#  Crea App Load Balancer - ELB
################################################################################

resource "random_pet" "this" {
  length = 2
}

resource "aws_s3_bucket" "bucket_elb_logs" {
  bucket = "s3-elb-logs-tf-asa-${random_pet.this.id}"
  # acl           = "private"
  force_destroy = true

  tags = {
    Name        = "Bucket ELB Logs ${var.mec2_project_name}"
    Environment = var.mec2_aws_ambiente
  }
}

resource "aws_elb" "elb_global" {
  name = "ELB-Global"

  subnets = [var.mec2_subnet_app_az1, var.mec2_subnet_app_az2]

  access_logs {
    bucket        = aws_s3_bucket.bucket_elb_logs.id
    bucket_prefix = "elb-log"
    interval      = 60
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.wp_az1.id}", "${aws_instance.wp_az2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name        = "ELB WPess ${var.mec2_project_name}"
    Environment = var.mec2_aws_ambiente
  }
}
