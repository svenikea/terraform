resource "aws_iam_role" "iam_role" {
    count                   = var.role_name != null ? 1 : 0
    name                    = "${var.project}-${var.env}-${var.role_name}"
    assume_role_policy      = var.assume_role_policy
    description             = "${var.project}-${var.env}-${var.role_name}"

    tags = {
        Name                = var.project
        Environment         = var.env
        Terraform           = true
    }
}

resource "aws_iam_role_policy_attachment" "role_policies" {
    count                   = var.attach_policies != null ? length(var.attach_policies) : 0
    role                    = aws_iam_role.iam_role[0].name
    policy_arn              = var.attach_policies[count.index]
}

resource "aws_iam_role_policy" "iam_role_policies" {
    count                   = var.inline_policy != null ? 1 : 0
    name                    = "${var.project}-${var.role_name}-${var.env}"
    role                    = aws_iam_role.iam_role[0].id
    policy                  = var.inline_policy
}