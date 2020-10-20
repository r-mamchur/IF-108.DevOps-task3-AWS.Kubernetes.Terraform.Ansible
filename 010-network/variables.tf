variable "region" {} 

variable "stage" {
   default = "default"
}
variable "vpc_cidr" {} 
variable "subn_a_priv_cidr" {}
variable "subn_a_pub_cidr" {}

variable "subn_b_priv_cidr" {
  default = "192.168.2.0/24"
}
variable "subn_b_pub_cidr" {
  default = "192.168.3.0/24"
}
variable "common_tags" {}
variable "nat_a_priv_ip" {
  default = "192.168.1.10"
}
variable "nat_b_priv_ip" {
  default = "192.168.3.10"
}
variable "allow_ports_nat" {
  default =  ["22"]
}
variable "instance_type_nat" {
  default = "t2.micro"
 }
variable "keyname" {
  default = ""
 }