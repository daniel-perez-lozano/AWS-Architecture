variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "app_public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "hub_private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}
variable "hub_public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "app_private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "key_pair" {
  description = "Name of the key pair to use for EC2 instances"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type = string
}

variable "secret_key" {
  description = "AWS secret key"    
  type = string  
}

variable "ami" {
  description = "AMI ID"
  type        = string
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]
}
variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
}