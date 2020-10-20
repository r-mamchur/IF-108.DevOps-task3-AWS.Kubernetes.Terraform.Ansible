#---------------------------region---------------------------------------------------------
provider "aws" {
  region = var.region
}
#---------------------------ami image -----------------------------------------------------
data "aws_ami" "latest_amazon_linux_nat" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }
}
#-------------------------network creation--------------------------------------------------
resource "aws_vpc" "vpc_e1" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool vpc1"))
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "gw_e1" {
  vpc_id = aws_vpc.vpc_e1.id
  tags   = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "IGW for vpc_e1"))
}
#----------------route tables ------------------------
resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.vpc_e1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_e1.id
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "pub_subn+igw"))
}
resource "aws_route_table" "private_subnet" {
    vpc_id = aws_vpc.vpc_e1.id
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat_server_a.id
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "priv_subn+nat_server"))

}
resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.subn_a_pub.id
  route_table_id = aws_route_table.public_subnet.id
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = aws_subnet.subn_b_pub.id
  route_table_id = aws_route_table.public_subnet.id
}

#-----------  
#  By default vpc route main_route
#    if zone[0] problem ==> nat_a not available then subnet_b 

resource "aws_route_table" "private_subnet_b" {
    vpc_id = aws_vpc.vpc_e1.id
  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat_server_b.id
  }
  tags = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "priv_subn_b+nat_server"))

}

resource "aws_route_table_association" "priv_subnet_b" {
  subnet_id      = aws_subnet.subn_b_priv.id
  route_table_id = aws_route_table.private_subnet_b.id
}
#-----

resource "aws_main_route_table_association" "main_subnets" {
  vpc_id      = aws_vpc.vpc_e1.id
  route_table_id = aws_route_table.private_subnet.id
}
#---------------subnets--------------------------------
resource "aws_subnet" "subn_a_priv" {
  vpc_id                  = aws_vpc.vpc_e1.id
  map_public_ip_on_launch = false
  cidr_block              = var.subn_a_priv_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool private subnet_a"))
}
resource "aws_subnet" "subn_a_pub" {
  vpc_id                  = aws_vpc.vpc_e1.id
  map_public_ip_on_launch = true
  cidr_block              = var.subn_a_pub_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool public subnet_a"))
}
resource "aws_subnet" "subn_b_priv" {
  vpc_id                  = aws_vpc.vpc_e1.id
  map_public_ip_on_launch = false
  cidr_block              = var.subn_b_priv_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags                    = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool private subnet_b"))
}
resource "aws_subnet" "subn_b_pub" {
  vpc_id                  = aws_vpc.vpc_e1.id
  map_public_ip_on_launch = true
  cidr_block              = var.subn_b_pub_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags                    = merge(var.common_tags, map("Stage", "${var.stage}"), map("Name", "eschool public subnet_b"))
}

#-------------security group for NAT--------------
resource "aws_security_group" "for_nat" {
  name        = "group_for_nat"
  description = "NAT SG"
  vpc_id      = aws_vpc.vpc_e1.id
  dynamic "ingress" {
    for_each = var.allow_ports_nat
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
tags = merge(var.common_tags, map("Name", "eschool NAT SG"))
}
#----------------------------NAT instance----------------------------------------------
resource "aws_instance" "nat_server_a" {
  ami           = data.aws_ami.latest_amazon_linux_nat.id
  instance_type = var.instance_type_nat
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_nat.id]
  subnet_id       = aws_subnet.subn_a_pub.id
  private_ip      = var.nat_a_priv_ip
#  user_data       = file("nat.sh")
  key_name        = var.keyname
  source_dest_check = false
 tags = merge(var.common_tags, map("Name", "nat_a"))
}
resource "aws_instance" "nat_server_b" {
  ami           = data.aws_ami.latest_amazon_linux_nat.id
  instance_type = var.instance_type_nat
  availability_zone = data.aws_availability_zones.available.names[1]
  security_groups = [aws_security_group.for_nat.id]
  subnet_id       = aws_subnet.subn_b_pub.id
  private_ip      = var.nat_b_priv_ip
#  user_data       = file("nat.sh")
  key_name        = var.keyname
  source_dest_check = false
 tags = merge(var.common_tags, map("Name", "nat_b"))
}
#  --------------------------------  instances for debug
resource "aws_instance" "ec_a" {
  ami           = "ami-0bb3fad3c0286ebd5"
  instance_type = var.instance_type_nat
  availability_zone = data.aws_availability_zones.available.names[0]
  security_groups = [aws_security_group.for_nat.id]
  subnet_id       = aws_subnet.subn_a_priv.id
  key_name        = var.keyname
  source_dest_check = false
 tags = merge(var.common_tags, map("Name", "ec_a"))
}

resource "aws_instance" "ec_b" {
  ami           = "ami-0bb3fad3c0286ebd5"
  instance_type = var.instance_type_nat
  availability_zone = data.aws_availability_zones.available.names[1]
  security_groups = [aws_security_group.for_nat.id]
  subnet_id       = aws_subnet.subn_b_priv.id
  key_name        = var.keyname
  source_dest_check = false
 tags = merge(var.common_tags, map("Name", "ec_b"))
}