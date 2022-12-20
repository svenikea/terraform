output "profile_name" {
    value = var.instance_profile != null ?  aws_iam_instance_profile.profiles[0].name : null
}
output "service_role" {
    value = var.new_roles != false ? aws_iam_role.iam_role[0].arn : null
}
output "iam_user_access_keys" {
    value = var.iam_users != null ? aws_iam_access_key.iam_user_access_key.*.id : null
}

data "template_file" "secret" {
  template  = var.iam_users != null ? join(",",aws_iam_access_key.iam_user_access_key.*.secret) : null
}

output "iam_user_secret" {
    value = var.iam_users != null ? split(",",data.template_file.secret.rendered) : null
}

output "iam_users" {
    value = var.iam_users != null ? aws_iam_user.iam_users.*.name : null
}