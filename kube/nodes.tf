
resource "aws_instance" "master" {
  ami           = "ami-0bb3fad3c0286ebd5"
  instance_type = var.instance_type_node
  availability_zone = data.terraform_remote_state.from_root.outputs.zone_0_name
  security_groups = [aws_security_group.for_node.id]
  subnet_id       = data.terraform_remote_state.from_root.outputs.subn_priv_a_id
#  private_ip      = var.node_b_priv_ip
#  user_data       = file("node.sh")
  key_name        = var.keyname
  tags = merge(var.common_tags, map("Name", "master"))

}
# =================================node
resource "aws_instance" "node1" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type_node
  availability_zone = data.terraform_remote_state.from_root.outputs.zone_1_name
  security_groups = [aws_security_group.for_node.id]
  subnet_id       = data.terraform_remote_state.from_root.outputs.subn_priv_b_id
#  private_ip      = var.node_b_priv_ip
#  user_data       = file("node.sh")
  key_name        = var.keyname
  tags = merge(var.common_tags, map("Name", "node1"))

}

# ============================
resource "null_resource" "ans_mas" {
  provisioner "local-exec" {
    command = "echo [masters] >> inv_kube && echo ${aws_instance.master.private_ip} >> inv_kube"
  }
}
resource "null_resource" "ans_node" {
  provisioner "local-exec" {
    command = "echo [workers] >> inv_kube && echo ${aws_instance.node1.private_ip} >> inv_kube"
  }
}



