variable "instance_type_bastion" {
  default = "t2.micro"
 }
 
variable common_tags {}

variable "allow_ports_bastion" {}
variable "vpc_id" {}
variable "subn_id" {}
variable "zone_name" {}

variable "keyname" {
  default = ""
}
variable "node_a_priv_ip" {
  default = "192.168.0.10"
}
variable "node_b_priv_ip" {
  default = "192.168.2.10"
}
variable "private_key_path" {
  default = ""
}

variable "aws_access_key" {}

variable "aws_secret_access_key" {}

variable "region" {}