/*resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, 0)
  key_name      = var.key_pair

  tags = {
    Name = "app-instance"
  }
}*/
variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "key_pair" {
  description = "Key pair name"
  type        = string
}

resource "aws_launch_configuration" "launch_config_front" {
  name          = "app-launch-configuration"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_pair

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "scalgrpfront_north1a" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.private_subnets
  launch_configuration = aws_launch_configuration.app.id

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.app.name
}
