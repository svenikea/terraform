resource "aws_acm_certificate" "domain_certificate" {
    count                     = var.route53_enable != false ? 1 : var.new_acm != false ? 1 : 0
    domain_name               = var.project_sub_domain != null ? "${var.project_sub_domain}.${var.project_domain}" : var.project_domain
    validation_method         = var.validation_method

    private_key               = var.validation_method == "NONE" ? var.private_key : null
    certificate_body          = var.validation_method == "NONE" ? var.certificate_body : null
    certificate_chain         = var.validation_method == "NONE" ? var.certificate_chain : null
}

resource "aws_route53_record" "current_record" {
    count                     = var.route53_enable != false ? 1 : 0
    allow_overwrite           = true
    name                      = tolist(aws_acm_certificate.domain_certificate[0].domain_validation_options)[0].resource_record_name
    records                   = [tolist(aws_acm_certificate.domain_certificate[0].domain_validation_options)[0].resource_record_value]
    type                      = tolist(aws_acm_certificate.domain_certificate[0].domain_validation_options)[0].resource_record_type
    zone_id                   = var.route53_enable != false ? data.aws_route53_zone.current_zone.id : var.new_acm != false ? data.aws_route53_zone.current_zone.id : "empty"
    ttl                       = 60
}

resource "aws_acm_certificate_validation" "validate_acm" {
    count                     = var.route53_enable != false ? 1 : 0
    certificate_arn           = aws_acm_certificate.domain_certificate[0].arn
    validation_record_fqdns   = [aws_route53_record.current_record[0].fqdn]
}