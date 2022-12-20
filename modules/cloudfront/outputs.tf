output "cloudfront_dns" {
    value = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_origin_identity_arn" {
    value = aws_cloudfront_origin_access_identity.cloudfront_oai.iam_arn
}

output "cloudfront_zone_id" {
    value = aws_cloudfront_distribution.cdn.hosted_zone_id
}