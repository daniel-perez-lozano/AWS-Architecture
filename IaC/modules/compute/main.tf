/*resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, 0)
  key_name      = var.key_pair

  tags = {
    Name = "app-instance"
  }
}*/
resource "aws_launch_configuration" "launch_config_app" {
  name_prefix   = "app-launch-configuration"
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
  vpc_zone_identifier  = [for subnet in var.private_subnets : subnet if subnet != "10.0.3.0/24" && subnet != "10.0.7.0/24" && subnet != "10.0.6.0/24"]
  launch_configuration = aws_launch_configuration.launch_config_app.id

  tag {
    key                 = "Name"
    value               = "scalgrpfront_north1a"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_group" "scalgrpfront_north1b" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [for subnet in var.private_subnets : subnet if subnet != "10.0.3.0/24" && subnet != "10.0.7.0/24" && subnet != "10.0.6.0/24"]
  launch_configuration = aws_launch_configuration.launch_config_app.id

  tag {
    key                 = "Name"
    value               = "scalgrpfront_north1b"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_group" "scalgrpbck_north1a" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [for subnet in var.private_subnets : subnet if subnet != "10.0.3.0/24" && subnet != "10.0.7.0/24" && subnet != "10.0.6.0/24"]
  launch_configuration = aws_launch_configuration.launch_config_app.id

  tag {
    key                 = "Name"
    value               = "scalgrpbck_north1a"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_group" "scalgrpbck_north1b" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [for subnet in var.private_subnets : subnet if subnet != "10.0.3.0/24" && subnet != "10.0.7.0/24" && subnet != "10.0.6.0/24"]
  launch_configuration = aws_launch_configuration.launch_config_app.id

  tag {
    key                 = "Name"
    value               = "scalgrpbck_north1b"
    propagate_at_launch = true
  }
}


output "autoscaling_group_name" {
  value =[
    aws_autoscaling_group.scalgrpbck_north1a.name,
    aws_autoscaling_group.scalgrpbck_north1b.name,
    aws_autoscaling_group.scalgrpfront_north1b.name,
    aws_autoscaling_group.scalgrpfront_north1a.name,
  ] 
  
}
