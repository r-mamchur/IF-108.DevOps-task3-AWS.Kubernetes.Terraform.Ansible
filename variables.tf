#
# GENERAL
#===================

#variable "project_name" {
#  default = "AWS_kube "
#}

#variable "ITA" {
#  description = "SoftServ IT Academy"
#  default     = "If.108-DevOps"
#}

variable "common_tags" {
  type = map
  default = {
    Owner   = "RM"
    Project = "AWS_kuber"
    ITA = "IF.108-DevOps"
  }
}

variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "192.168.0.0/20"
}

variable "subn_a_priv_cidr" {
  default = "192.168.0.0/24"
}
variable "subn_a_pub_cidr" {
  default = "192.168.1.0/24"
}

variable "allow_ports_bastion" {
  default =  ["22", "8080", "8111"]
}

variable "keyname" {
  default = "rm-ireland"
 }
 
variable "private_key_path" {
  default = "./rm-ireland.pem"
}

variable "aws_access_key" {
  default = "--"
}

variable "aws_secret_access_key" {
  default = "==="
}

 
 
 