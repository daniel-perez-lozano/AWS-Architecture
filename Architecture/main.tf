<<<<<<< HEAD
<<<<<<< HEAD
module "vpc" {
  source = "./modules/vpc"
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key 
}

module "networking" {
  source     = "./modules/networking"
  vpc_id     = module.vpc.vpc_id
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "compute" {
  source          = "./modules/compute"
  instance_type   = var.instance_type
  public_subnets  = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
  key_pair        = var.key_pair
}

module "security" {
  source          = "./modules/security"
  security_groups = var.security_groups
}
=======
=======
>>>>>>> 6ce4f43c1bae27dd7d2c10e6702acee4317643be
provider "aws" {
  region = "eu-north-1"
  access_key = 
  secret_key = 
}

# resource "aws_instance" "example2" {
#   ami = "ami-094a9a574d190f541"
#   instance_type = "t3.micro"
# }

resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "app_vpc"    
  }
}

resource "aws_subnet" "public_lb_fargate_subnet" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = "10.0.8.0/24"

  tags = {
    Name = "public_lb_fargate_subnet"
  }
<<<<<<< HEAD
}
>>>>>>> 6ce4f43c1bae27dd7d2c10e6702acee4317643be
=======
}
>>>>>>> 6ce4f43c1bae27dd7d2c10e6702acee4317643be
