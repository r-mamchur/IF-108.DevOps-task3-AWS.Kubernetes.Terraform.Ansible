provider "aws" {
  region = var.region
}

module "network" {
  source         = "./010-network"
  region = var.region
  common_tags    = var.common_tags
  vpc_cidr       = var.vpc_cidr
  subn_a_priv_cidr = var.subn_a_priv_cidr
  subn_a_pub_cidr  = var.subn_a_pub_cidr
  keyname        = var.keyname
}

#resource "null_resource" "ans_mas" {
#  provisioner "local-exec" {
#    command = "echo <<EOT
#     echo vpc_id = ${module.network.vpc_e1_id}  var_kube 
#     echo zone = ${module.network.zone_0_name}  var_kube 
#     echo subn_id = ${module.network.subn_pub_id}
#     EOT >> var_kube"
#  }
#}

#resource "null_resource" "ans_mas" {
#  provisioner "local-exec" {
#    command = "echo [masters] >> var_kube  \n
#    && echo vpc_id = ${module.network.vpc_e1_id} >> var_kube \n
#    && echo zone = ${module.network.zone_0_name} >> var_kube \n
#    && echo subn_id = ${module.network.subn_pub_id} >> var_kube"
#  }
#}

module "dbs" {
  source         = "./020-DBs"
  region = var.region
  vpc_id = module.network.vpc_e1_id
  subn_a_id = module.network.subn_a_priv_id
  subn_b_id = module.network.subn_b_priv_id
  zone_name = module.network.zone_0_name
  common_tags    = var.common_tags
}


module "bastion" {
  source         = "./030-bastion"
  region = var.region
  vpc_id = module.network.vpc_e1_id
  subn_id = module.network.subn_a_pub_id
  zone_name = module.network.zone_0_name
  allow_ports_bastion = var.allow_ports_bastion
  common_tags    = var.common_tags
  keyname        = var.keyname
  private_key_path = var.private_key_path
  aws_access_key = var.aws_access_key
  aws_secret_access_key  =  var.aws_secret_access_key
}
