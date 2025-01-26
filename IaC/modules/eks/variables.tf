variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role to use for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.21"
}

variable "node_role_arn" {
  description = "The ARN of the IAM role to use for the EKS node group"
  type        = string
}

variable "desired_capacity" {
  description = "The desired number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "The maximum number of nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "min_capacity" {
  description = "The minimum number of nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "The instance type to use for the EKS node group"
  type        = string
  default     = "t3.medium"
}