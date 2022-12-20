resource "aws_elastic_beanstalk_environment" "beanstalk_env" {
    name                    = "${var.project}-${var.env}"
    application             = var.application
    solution_stack_name     = var.solution_stack_name != null ? var.solution_stack_name : null
    platform_arn            = var.platform_arn != null ? var.platform_arn : null
    tier                    = var.tier != null ? var.tier : null

    dynamic "setting" {
        for_each            = var.settings != null ? var.settings : []
        content {
            namespace       = setting.value.namespace
            name            = setting.value.name
            value           = setting.value.value
        }
    }
 }