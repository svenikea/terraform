# Network Module

This module will create VPC services like subnets, ALCs, gateway, etc...

If you want to have a separate VPC for every environment then add the var.env to every `.tf` file except `variables.tf` you will need to declare that variable

## Terraform definition example

```terraform
module "<module name>" {
    source              = "../modules/network"
    project             = "<project name>"
    region              = "<region>"
    vpc_cidr_block      = "<vpc cidr>"
    public_subnets      = "<list of public subnets>
    private_subnets     = "<list of private subnets>
    new_elastic_ip      = "<to enable elastic ip>
    nat_gateway         = "<to enable nat gateway>
    public_routes       = [
        {
            cidr_block  = "<ipv4 cidr>"
            gateway_id  = "<gateway id>"
        },
        .
        .
        .
    ]
    private_routes      = [
        {
            cidr_block = "<ipv4 cidr>"
            gateway_id = "<gateway id>"
        },
        .
        .
        .
    ]
    endpoint_service = {
        <service endpoint> = {
            policy  = "<JSON policy>"
            dns_enabled = "<to enable dns>"
        },
        .
        .
        .
    }
    public_subnet_acl_ingress = [
        {
            protocol    = "<protocol>"
            rule_no     = "<rule number>"
            action      = "<allow/deny>"
            cidr_block  = "<cidr block>"
            from_port   = "<from port>"
            to_port     = "<to port>"
        },
        .
        .
        .
    ]
    private_subnet_acl_ingress = [
        {
            
        },
        .
        .
        .
    ]
    public_subnet_acl_egress = [
        {

        },
        .
        .
        .
    ]
    private_subnet_acl_egress = [
        {
            
        },
        .
        .
        .
    ]
}
```

## Variables 

| Variables                 | Usage                         |Type           |
|---------------------------|-------------------------------|---------------|
|project(*)                 |The name of projet             |`String`       |
|region(*)                  |Region name                    |`String`       |
|vpc_cidr_block             |IPv4 of VPC                    |`String`       |
|public_subnets             |Subnets IPv4 CIDR              |`List`         |
|private_subnets            |Subnets IPv4 CIDR              |`List`         |
|public_routes              |Public routes                  |`Map`          |
|private_routes             |Private routes                 |`Map`          |
|endpoint_service           |Service endpoint config        |`Map`          |
|public_subnet_acl_ingress  |Public ACLs ingress            |`Map`          |
|private_subnet_acl_ingress |Public ACLs ingress            |`Map`          |
|public_subnet_acl_egress   |Public ACLs ingress            |`Map`          |
|private_subnet_acl_egress  |Public ACLs ingress            |`Map`          |


_(*) = required variable._

## Outputs

| output                    | Value                             |Type               |
|---------------------------|-----------------------------------|-------------------|
|vpc_id                     |VPC ID                             |`String`           |
|igw_id                     |Gateway ID                         |`String`           |
|private_subnets            |Private ubnet IDs                  |`List`             |
|public_subnets             |Public ubnet IDs                   |`List`             |
|nat_gateway_public_ip      |Nat Gateway ID                     |`String`           |
|public_route_table_name    |Public route table name            |`List`             |
|private_route_table_name   |Private route table name           |`List`             |
|public_route_table_id      |Public route table IDs             |`List`             |
|private_route_table_id     |Private route table IDs            |`List`             |