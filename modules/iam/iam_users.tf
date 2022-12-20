resource "aws_iam_user" "iam_users" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    name                    = var.iam_users[count.index]
    path                    = "/"

    tags = {
        Name                = "${var.iam_users[count.index]}"
        Environment         = var.env
        Terraform           = true
    }
}

resource "aws_iam_access_key" "iam_user_access_key" {
    count                   = var.iam_users != null ? length(var.iam_users) : 0
    user                    = aws_iam_user.iam_users[count.index].name
}