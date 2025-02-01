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
  source = "./modules/networking"
  hub_vpc_id = module.vpc.hub_vpc_id
  app_vpc_id = module.vpc.app_vpc_id
  app_private_subnets = var.app_private_subnets
  app_public_subnets = var.app_public_subnets
  availability_zones = var.availability_zones

}

module "compute" {
  source          = "./modules/compute"
  ami             = var.ami
  instance_type   = var.instance_type
  private_subnets = module.networking.app_private_subnets
  key_pair        = var.key_pair
}


module "security" {
  source          = "./modules/security"
  app_vpc_id      = module.vpc.app_vpc_id
  hub_vpc_id      = module.vpc.hub_vpc_id
  }



resource "aws_lb" "app_lb_front" {
  name               = "app-lb-front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.app_security_group_id]
  subnets            = [module.networking.app_public_subnets[0]]


  enable_deletion_protection = false

  tags = {
    Name = "app-lb-front"
  }
}

resource "aws_lb" "app_lb_k8s" {
  name               = "app-lb-k8s"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.app_security_group_id]
  subnets            = [module.networking.app_public_subnets[1]]

  enable_deletion_protection = false

  tags = {
    Name = "app-lb-k8s"
  }
}

resource "aws_lb" "app_lb_bck" {
  name               = "app-lb-bck"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security.app_security_group_id]
  subnets            = [for subnet in module.networking.app_private_subnets : subnet if cidrsubnet(subnet, 8, 0) == "10.0.3.0/24"]

  enable_deletion_protection = false

  tags = {
    Name = "app-lb-bck"
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_mode             = "serverless"
  iam_database_authentication_enabled = true
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = [module.security.app_security_group_id]
  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 2
    seconds_until_auto_pause = 300
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count              = 2
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  publicly_accessible = false
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = [for subnet in module.networking.app_private_subnets : subnet if cidrsubnet(subnet, 8, 0) == "10.0.6.0/24"]
  tags = {
    Name = "aurora-subnet-group"
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.1.0"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"
  subnets         = [for subnet in module.networking.app_private_subnets : subnet if cidrsubnet(subnet, 8, 0) == "10.0.7.0/24" || cidrsubnet(subnet, 8, 0) == "10.0.9.0/24"]
  vpc_id          = module.vpc.app_vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"

      key_name = var.key_pair
    }
  }
}

resource "aws_ecr_repository" "my_repo" {
  name = "my-ecr-repo"
}

resource "aws_iam_role" "eks_task_execution_role" {
  name = "eksTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}
 resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  role       = aws_iam_role.eks_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}
