variable "project" { default = null }
variable "env" { default = null }
variable "role_name" { default = null }
variable "assume_role_policy" { default = null }
variable "attach_policies" { default = null }
variable "instance_profile" { default = null }
variable "inline_policy" { default = null }
variable "group_name" { default = null }
variable "iam_users" { default = null }
variable "group_policies" { default = null }
# variable "credentials_output_path" { default = null }
# locals {
#     aws_creds = [for x,y in zipmap(var.iam_users != null ? aws_iam_access_key.iam_user_access_key.*.id : [],var.iam_users != null ? split(",",data.template_file.secret.rendered) : []) : {
#         access_id   = x
#         secret_key  = y
#     }]
#     constructed = [for a,b in zipmap(var.iam_users != null ? aws_iam_user.iam_users.*.name : [],local.aws_creds) : {
#         "${a}" = b
#     }]
#     default_path_credentials = "${abspath(path.root)}/../../credentials/creds.json"
# }