# Security Group Ingress Module

This module will create security group ingress 

## Terraform definition

```terraform
module "<module name>" {
    source = "../modules/security_group_ingress
}
```

## Variables 

| Variables             | Usage                             |   
|-----------------------|-----------------------------------|
|ipv4_cidr_blocks       |A list of IPv4 CIDR Block          |
|port                   |allowed port                       |
|security_group_id      |Security group ID                  |
|source_security_groups |Source Inbound from security group |
