resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_subnets)
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnets[count.index]
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}
