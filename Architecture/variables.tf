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

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
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
