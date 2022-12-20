variable "cloudfront_aliases" {}
variable "price_class" {}
variable "env" {}
variable "cloudfront_behavior" {}
variable "target_id" {}
variable "acm_arn" {}
variable "origins" {}
variable "whitelisted_names" {
    default = null
}
variable "oai_name" {}
variable "cookie_type" {}