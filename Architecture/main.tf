// terraform plan -var-file="secrets.tfvars"
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"
}

module "networking" {
  source     = "./modules/networking"
  vpc_id     = module.vpc.vpc_hub_id
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  availability_zones = var.availability_zones

}

module "compute" {
  source          = "./modules/compute"
  ami             = var.ami
  instance_type   = var.instance_type
  private_subnets = module.networking.private_subnets
  key_pair        = var.key_pair
}


module "security" {
  source          = "./modules/security"
  vpc_id          = module.vpc.vpc_hub_id
  }

resource "aws_lb" "app_lb_multitier" {
  name               = "app-lb-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.security_group_id]
  subnets            = [module.networking.public_subnets[0]]


  enable_deletion_protection = false

  tags = {
    Name = "app-lb-1"
  }
}

resource "aws_lb" "app_lb_k8s" {
  name               = "app-lb-k8s"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.security_group_id]
  subnets            = [module.networking.public_subnets[1]]

  enable_deletion_protection = false

  tags = {
    Name = "app-lb-k8s"
  }
}

