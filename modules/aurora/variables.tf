variable "project" {}
variable "env" {}

variable "aurora_instance_class" {}
variable "aurora_instance_number" {}
variable "aurora_engine" {}
variable "aurora_engine_version" {}
variable "aurora_user" {}
variable "private_subnets" {}
variable "aurora_backup_retention_period" {}
variable "aurora_database_name" {}
variable "aurora_sg" {}
variable "random_string_length" {}
variable "aurora_availability_zone" {}
variable "aurora_skip_final_snapshot" {
    default = true
}
variable "aurora_multi_az" {
    default = false
} 
variable "aurora_storage_type" {
    default = "gp"
}
variable "aurora_parameter_group" {
    default = null
}
variable "new_cluster" {
    default = null
}
variable "new_instance" {
    default = false
}
