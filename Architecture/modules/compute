resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, 0)
  key_name      = var.key_pair

  tags = {
    Name = "app-instance"
  }
}
