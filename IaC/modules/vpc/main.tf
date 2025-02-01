resource "aws_vpc" "app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "app_vpc"
  }
}

resource "aws_vpc" "hub_vpc" {
  cidr_block           = "172.17.0.0/20"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "hub_vpc"
  }
}

resource "aws_internet_gateway" "hub_igw" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.hub_vpc.id
}

output "app_vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "hub_vpc_id" {
  value = aws_vpc.hub_vpc.id
}
