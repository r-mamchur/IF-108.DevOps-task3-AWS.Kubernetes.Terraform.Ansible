data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
#-------------security group for node-------------
resource "aws_security_group" "for_bastion" {
  name        = "group_for_bastion"
  description = "Bastion SG"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.allow_ports_bastion
    content {
      description = "Dynamic ingress port open"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = merge(var.common_tags, map("Name", "eschool node SG"))
}
#----------------------------Node instances----------------------------------------------
