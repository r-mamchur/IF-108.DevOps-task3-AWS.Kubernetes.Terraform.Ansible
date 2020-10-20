#t2.large t2.medium   t2.micro
instance_type_node       = "t2.micro"
allow_ports_node         =  ["22", "8080"]
keyname                  = "rm-ireland"
node_a_priv_ip           = "172.10.0.10"
node_b_priv_ip           = "172.10.2.10"
private_key_path         = "./rm-ireland.pem"

aws_access_key   = "---"

aws_secret_access_key = "--"

aws_region = "eu-west-1"

