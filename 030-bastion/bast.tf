
resource "aws_instance" "camel3" {
  ami           = "ami-0bb3fad3c0286ebd5"
  instance_type = var.instance_type_bastion
  availability_zone = var.zone_name
  security_groups = [aws_security_group.for_bastion.id]
  subnet_id       = var.subn_id
#  private_ip      = var.node_b_priv_ip
#  user_data       = file("node.sh")
  key_name        = var.keyname
  tags = merge(var.common_tags, map("Name", "camel3"))

 connection {
    type = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host = self.public_ip
  } 

  provisioner "file" {
    source      = "./kube"
    destination = "$HOME"
  }

  provisioner "file" {
    source      = "rm-ireland.pem"
    destination = "$HOME/rm-ireland.pem"
  }

  provisioner "file" {
    source      = "./030-bastion/roles"
    destination = "$HOME"
  }
  provisioner "file" {
    source      = "./030-bastion/ansible.cfg"
    destination = "$HOME/ansible.cfg"
  }
  provisioner "file" {
    source      = "./030-bastion/playbook_bast.yml"
    destination = "$HOME/playbook_bast.yml"
  }

  provisioner "file" {
    source      = "./030-bastion/conf_vars.yml"
    destination = "$HOME/conf_vars.yml"
  }

  provisioner "file" {
    source      = "./030-bastion/inv_localhost"
    destination = "$HOME/inv_localhost"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "sudo /usr/bin/ansible-playbook -v -i inv_localhost ./playbook_bast.yml >ans",
      "sudo aws configure set aws_access_key_id ${var.aws_access_key}",
      "sudo aws configure set aws_secret_access_key ${var.aws_secret_access_key}",      
      "sudo aws configure set default.region ${var.region}",
      "cd kube",
      "sudo terraform init",
      "sudo chmod -R a+x ./.terraform/plugins/"
    ]
  }

}

