resource "aws_acm_certificate" "domain_certificate" {
    domain_name               = var.project_domain
    validation_method         = var.validation_method

    private_key               = var.validation_method == "NONE" ? var.private_key : null
    certificate_body          = var.validation_method == "NONE" ? var.certificate_body : null
    certificate_chain         = var.validation_method == "NONE" ? var.certificate_chain : null
}
