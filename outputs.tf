
#output "nat_a_oo" {
#  value = module.network.nat_a_pub
#}

output "nat_a_oo_ip" {
  value = module.network.nat_a_pub.public_ip
}

output "vpc_id" {
  value = module.network.vpc_e1_id
}

output "zone_0_name" {
  value = module.network.zone_0_name
}

output "zone_1_name" {
  value = module.network.zone_1_name
}

output "zones" {
  value = module.network.zones_name
}

output "subn_pub_a_id" {
  value = module.network.subn_a_pub_id
}

output "subn_priv_a_id" {
  value = module.network.subn_a_priv_id
}

output "subn_pub_b_id" {
  value = module.network.subn_b_pub_id
}

output "subn_priv_b_id" {
  value = module.network.subn_b_priv_id
}


output "db_eschool_endpoint" {
  value = "module.dbs.instances[0]endpoint"
}

#output "my_address" {
#  value = module.dbs.my_address
#}
#output "my_endpoint" {
#  value = module.dbs.my_endpoint
#}
