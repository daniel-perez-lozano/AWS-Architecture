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