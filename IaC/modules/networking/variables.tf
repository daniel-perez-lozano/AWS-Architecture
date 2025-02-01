variable "app_vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "hub_vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "app_public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "app_private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}