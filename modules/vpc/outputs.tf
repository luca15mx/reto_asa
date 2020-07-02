output "vpc-defalut-info" {
  value = "VPC Tenacy : ${aws_vpc.default.instance_tenancy} VPC ID : ${aws_vpc.default.id}"
}