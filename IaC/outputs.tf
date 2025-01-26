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
  value = aws_lb.app_lb_front.arn
}

output "app_lb_2_arn" {
  value = aws_lb.app_lb_k8s
}
output "app_lb_3_arn" {
  value = aws_lb.app_lb_bck
}
output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_cluster_reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}
output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  value = module.eks.kubeconfig
}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_repo.repository_url
}