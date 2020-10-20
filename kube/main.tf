#-------------- get vpc data  -----------------------------------------------------
data "terraform_remote_state" "from_root" { 
  backend = "local"
  config = {
    path = "../terraform.tfstate"
  }
}
provider "aws" {
  region = "eu-west-1"
}
#---------------------------ami image -----------------------------------------------------
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
#-------------security group for node-------------
resource "aws_security_group" "for_node" {
  name        = "group_for_node"
  description = "node SG"
  vpc_id      = data.terraform_remote_state.from_root.outputs.vpc_id
  dynamic "ingress" {
    for_each = var.allow_ports_node
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
