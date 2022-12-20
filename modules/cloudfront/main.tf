resource "aws_cloudfront_distribution" "cdn" {
    aliases                 = var.cloudfront_aliases
    enabled                 = true
    is_ipv6_enabled         = true
    price_class             = var.price_class
    retain_on_delete        = false
    wait_for_deployment     = false

    dynamic "origin" {
        for_each            = var.origins
        content {
            domain_name     = origin.value.domain_name
            origin_id       = origin.value.target_id
            dynamic "s3_origin_config" {
                for_each    = origin.value.s3_origin == true ? ["${origin.value.domain_name}"] : []
                content {
                    origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_oai.cloudfront_access_identity_path
                }
            }
            dynamic "custom_origin_config" {
                for_each    = origin.value.custom_origin == true ? ["${origin.value.domain_name}"] : []
                content {
                    http_port              = 80
                    https_port             = 443
                    origin_protocol_policy = origin.value.protocol_policy
                    origin_ssl_protocols   = ["TLSv1.2"]
                }
            }
        } 
    }
    default_cache_behavior {
        allowed_methods                 = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods                  = ["GET", "HEAD", "OPTIONS"]
        viewer_protocol_policy          = "redirect-to-https"
        target_origin_id                = var.target_id
        forwarded_values {
            query_string                = false
            cookies {
                forward                 = var.cookie_type
                whitelisted_names       = var.cookie_type != "none" ? var.whitelisted_names : null
            } 
        }
    }
    dynamic "ordered_cache_behavior" {
        for_each                        = var.cloudfront_behavior
        content {
            path_pattern                = ordered_cache_behavior.value.path
            allowed_methods             = ordered_cache_behavior.value.allowed_methods
            cached_methods              = ordered_cache_behavior.value.cached_methods
            target_origin_id            = ordered_cache_behavior.value.target_id

            forwarded_values {
            query_string                = ordered_cache_behavior.value.query_Strng
            headers                     = ordered_cache_behavior.value.headers

            cookies {
                    forward             = ordered_cache_behavior.value.cookies
                    whitelisted_names   = ordered_cache_behavior.value.whitelist_names
                }
            }

            min_ttl                     = 0
            default_ttl                 = 86400
            max_ttl                     = 31536000
            compress                    = true
            viewer_protocol_policy      = ordered_cache_behavior.value.viewer_protocol_policy
        }
    }
    restrictions {
        geo_restriction {
            restriction_type            = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn             = var.acm_arn
        ssl_support_method              = "sni-only"
    }

    tags = {
        Environment                     = var.env
    }  
}

resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
    comment                             = "${var.oai_name} OAI"
}