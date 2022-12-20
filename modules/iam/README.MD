# IAM Module

This module will create services like IAM groups, users, and profile

## Terraform definition example

```terraform
module "<module name>" {
    source              = "../modules/iam"
    role_name           = "<role name>"          
    project             = "<project name>"
    env                 = "<project environment>"
    instance_profile    = "<instance profile name>"
    assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "<service name>.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
    attach_policies     = "<aws managed policies>"
    inline_policy       = "<user custom policies>"
}
```

## Variables 

| Variables         | Usage                         |
|-------------------|-------------------------------|
|role_name(*)       |IAM role name                  |
|env(*)             |Environment of the project     |
|instance_profile   |Instance profile name          |
|project(*)         |The name of projet             |
|assume_role_policy |Service to assume this role    |
|attach_policies    |AWS Managed policy to attach   |
|inline_policy      |User custom policy             |

_(*) = required variable._

## Outputs

| output                | Value                             |
|-----------------------|-----------------------------------|
|profile_name           |The name of the instance profile   | 
|service_role           |ARN of service role                |
|iam_user_access_keys   |IAM user access key                |
|iam_user_secret        |IAM user secret key                |
|iam_users              |List of iam users                  |
