# AWS ACM Module

This module will create certificate with 2 options

* DNS validation from Route 53 
* DNS validation from other DNS provider (This method requires certificate key as well as private key)

## Terraform definition example

```terraform
module "acm_stg" {
    source              = "../modules/acm"
    project_domain      = var.project_domain
    project_sub_domain  = "stg"
    validation_method   = "DNS"
    route53_enable      = var.route53_enable
    new_acm             = var.new_acm  
}
```

## Variables 

| Variables                 | Usage                         |Type                                  |
|---------------------------|-------------------------------|----------------------|---------------|
|project_domain(*)          |The root domain                                       |`String`       |
|project_sub_domain         |The root sub-domain                                   |`String`       |
|validation_method(*)       |Method to vaildate certificate                        |`String`       |
|route53_enable(*)          |Is the root domain reside at route 53                 |`Boolean`      |
|new_acm                    |To Create new certificate                             |`Boolean`      |

_(*) = required variable._

## Outputs

| output                    | Value                             |Type               |
|---------------------------|-----------------------------------|-------------------|
|acm_arnn                   |ACM certificate ARN                |`String`           |