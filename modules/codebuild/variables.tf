variable "project" {}
variable "env" {}
variable "codebuild_role" {}
variable "build_compute_type" {}
variable "build_image" {}
variable "build_privileged_mode" {}
variable "build_type" {}
variable "cache_config" { default = null }
variable "build_artifact" {}
variable "codebuild_vpc_config" { default = null }
variable "source_config" { default = null }
variable "codebuild_variables" { default = null }