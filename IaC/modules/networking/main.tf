resource "aws_subnet" "app_public_subnets" {
  count             = length(var.app_public_subnets)
  vpc_id            = var.app_vpc_id
  cidr_block        = var.app_public_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))

  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}
resource "aws_subnet" "app_private_subnets" {
  count      = length(var.app_private_subnets)
  vpc_id     = var.app_vpc_id
  cidr_block = var.app_private_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))

  tags = {
    Name = "app-private-subnet-${count.index + 1}"
  }
}

output "app_private_subnets" {
  value = aws_subnet.app_private_subnets[*].id
}
output "app_public_subnets" {
  value = aws_subnet.app_public_subnets[*].id
}
