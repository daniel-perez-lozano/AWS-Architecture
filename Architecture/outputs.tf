output "vpc_app_id" {
  value = module.vpc.vpc_app_id
}

output "vpc_hub_id" {
  value = module.vpc.vpc_hub_id
}

output "public_subnet_1_id" {
  value = module.networking.public_subnets[0]
}

output "public_subnet_2_id" {
  value = module.networking.public_subnets[1]
}

output "app_lb_1_arn" {
  value = aws_lb.app_lb_multitier.arn
}

output "app_lb_2_arn" {
  value = aws_lb.app_lb_k8s
}
