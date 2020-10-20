variable common_tags {}
variable zone_name {}
variable subn_a_id {}
variable subn_b_id {}
variable vpc_id {}
variable region {}

variable "allocated_storage" {
  default = "20"
}
variable "max_allocated_storage" {
  default = "30"
}


# -----------------------TeamCity
variable "rds_ts_storage_type" {
  default = "gp2"
}
variable "rds_ts_engine" {
  default = "postgres"
}
variable "rds_tc_engine_version" {
  default = "9.6.8"
}
variable "rds_tc_instance_class" {
  default = "db.t2.micro"
}
variable "rds_parameter_group_name" {
  default = "default.mysql5.7"
}

variable "rds_tc_name" {
  default = "tc"
}
variable "rds_tc_db_username" {
  default = "tc"
}
variable "rds_tc_db_password" {
  default = "Passw0rd"
}

# -----------------------Sonar
variable "rds_sonar_storage_type" {
  default = "gp2"
}
variable "rds_sonar_engine" {
  default = "postgres"
}
variable "rds_sonar_engine_version" {
  default = "9.6.8"
}
variable "rds_sonar_instance_class" {
  default = "db.t2.micro"
}
variable "rds_sonar_name" {
  default = "sonar"
}
variable "rds_sonar_db_username" {
  default = "sonar"
}
variable "rds_sonar_db_password" {
  default = "Passw0rd"
}

# ----------------------- eSchool
variable "rds_es_storage_type" {
  default = "gp2"
}
variable "rds_es_engine" {
  default = "mysql"
}
variable "rds_es_engine_version" {
  default = "5.7"
}
variable "rds_es_instance_class" {
  default = "db.t2.micro"
}
variable "rds_es_parameter_group_name" {
  default = "default.mysql5.7"
}
variable "rds_es_name" {
  default = "eschool"
}
variable "rds_es_db_username" {
  default = "eschool"
}
variable "rds_es_db_password" {
  default = "Passw0rd"
}
