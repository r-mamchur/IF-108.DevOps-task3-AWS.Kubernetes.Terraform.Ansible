output "region" {
  value = var.region
}
output "ami_nat" {
  value = data.aws_ami.latest_amazon_linux_nat.id
}
output "stage" {
  value = var.stage
}
output "vpc_e1_id" {
  value = aws_vpc.vpc_e1.id
}
output "zone_0_name" {
  value = data.aws_availability_zones.available.names[0]
}
output "zone_1_name" {
  value = data.aws_availability_zones.available.names[1]
}

output "zones_name" {
  value = data.aws_availability_zones.available.names
}

output "subn_a_priv_id" {
  value = aws_subnet.subn_a_priv.id
}
output "subn_a_pub_id" {
  value = aws_subnet.subn_a_pub.id
}
output "subn_b_priv_id" {
  value = aws_subnet.subn_b_priv.id
}
output "subn_b_pub_id" {
  value = aws_subnet.subn_b_pub.id
}
output "nat_a_pub_ip" {
  value = aws_instance.nat_server_a.public_ip
}
output "nat_a_pub" {
  value = aws_instance.nat_server_a
}
output "common_tags" {
  value = var.common_tags
}
