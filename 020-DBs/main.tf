#-------------- get vpc data  -----------------------------------------------------

resource "aws_db_subnet_group" "rds_private_rm" {
  name        = "rds_private_rm"
  description = "private subnets for rds instance"
  subnet_ids  = [var.subn_a_id, var.subn_b_id]
}

#-------------- Define RDS DB -----------------------------------------------------
resource "aws_db_instance" "eshool" {
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.rds_es_storage_type
  engine                = var.rds_es_engine
  engine_version        = var.rds_es_engine_version
  instance_class        = var.rds_es_instance_class
  identifier           = "mysql-eschool"
  name                  = var.rds_es_name
  username              = var.rds_es_db_username
  password              = var.rds_es_db_password
  parameter_group_name  = var.rds_es_parameter_group_name
  db_subnet_group_name       = aws_db_subnet_group.rds_private_rm.name
  availability_zone =   var.zone_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  deletion_protection = false
  skip_final_snapshot = true
}

#            TeamCity
resource "aws_db_instance" "tc" {
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.rds_ts_storage_type
  engine                = var.rds_ts_engine
  engine_version        = var.rds_tc_engine_version
  instance_class        = var.rds_tc_instance_class
  identifier           = "psql-tc"
  name                  = var.rds_tc_name
  username              = var.rds_tc_db_username
  password              = var.rds_tc_db_password
  db_subnet_group_name       = aws_db_subnet_group.rds_private_rm.name
  availability_zone =   var.zone_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  deletion_protection = false
  skip_final_snapshot = true
}

resource "aws_db_instance" "sonar" {
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.rds_sonar_storage_type
  engine                = var.rds_sonar_engine
  engine_version        = var.rds_sonar_engine_version
  instance_class        = var.rds_sonar_instance_class
  identifier           = "psql-sonar"
  name                  = var.rds_sonar_name
  username              = var.rds_sonar_db_username
  password              = var.rds_sonar_db_password
  db_subnet_group_name       = aws_db_subnet_group.rds_private_rm.name
  availability_zone =   var.zone_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  deletion_protection = false
  skip_final_snapshot = true
}

