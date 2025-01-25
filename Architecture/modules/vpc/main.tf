resource "aws_vpc" "vpc_app" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "app_vpc"
  }
}
resource "aws_vpc" "vpc_hub" {
  cidr_block           = "172.17.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "hub_vpc"
  }
}
resource "aws_internet_gateway" "igw_hub" {
  vpc_id = aws_vpc.vpc_app.id
}
resource "aws_internet_gateway" "igw_app" {
  vpc_id = aws_vpc.vpc_hub.id
}

output "vpc_app_id" {
  value = aws_vpc.vpc_app.id
}

output "vpc_hub_id" {
  value = aws_vpc.vpc_hub.id
}
