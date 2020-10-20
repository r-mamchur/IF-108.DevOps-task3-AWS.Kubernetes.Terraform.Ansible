variable "instance_type_node" {
  default = "t2.micro"
 }
variable "allow_ports_node" {
  default =  ["22"]
}
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

variable "common_tags" {
  type = map
  default = {
    Owner   = "RM"
    Project = "AWS_kuber"
    ITA = "IF.108-DevOps"
  }
}

variable "aws_access_key" {}

variable "aws_secret_access_key" {}

variable "aws_region" {}