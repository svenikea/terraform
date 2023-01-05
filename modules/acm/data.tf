data "aws_route53_zone" "current_zone" {
  name         = "${var.project_domain}"
  private_zone = false
}