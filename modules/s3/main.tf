resource "aws_s3_bucket" "s3_bucket" {
    count           = var.bucket_name != null ? length(var.bucket_name) : 0
    bucket          = "${var.bucket_name[count.index]}"

    tags = {
        Name        = "${var.project}"
        Environment = "${var.env}"
        Terraform   = true
    }
}