output "name" {
    value = var.new_app == true ? aws_elasticbeanstalk_application.beanstalk_app[0].name : var.project
}