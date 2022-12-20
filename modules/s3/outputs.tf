output "bucket_list" {
    value = aws_s3_bucket.s3_bucket.*.bucket
}