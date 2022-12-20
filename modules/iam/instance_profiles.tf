resource "aws_iam_instance_profile" "profiles" {
    count               = var.instance_profile != null ? 1 : 0
    name                = "${var.project}-${var.instance_profile}-${var.env}"
    role                = aws_iam_role.iam_role[0].name
}