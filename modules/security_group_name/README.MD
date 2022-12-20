# Security Group Module

This module will create security group name with outound set to all

## Terraform definition

```terraform
module "<module name>" {
    source = "../modules/security_group_name
}
```

## Variables 

| Variables | Usage                     |
|-----------|---------------------------|
|vpc_id     |VPC ID                     |
|env        |Environment of the project |
|sg_name    |The name of security group |
|project    |The name of projet         |


## Outputs

| output    | Value                     |
|-----------|---------------------------|
| id        | The id of security group  | 
