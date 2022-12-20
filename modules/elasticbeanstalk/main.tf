resource "aws_elasticbeanstalk_application" "beanstalk_app" {
    count           = var.new_app == true ? 1 : 0
    name            = "${var.project}"
    description     = "${var.project}"

    tags = {
        Name        = var.project
        Terraform   = true
    }
}
