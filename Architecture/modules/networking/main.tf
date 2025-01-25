variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}


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

output "private_subnets" {
  value = aws_subnet.private[*].id
}
output "public_subnets" {
  value = aws_subnet.public[*].id
}