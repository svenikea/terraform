# CodeBuild Module

This module will create codebuild project

## Terraform definition example

```terraform
module "<module name>" {
    source                          = "../modules/codebuild"
    project                         = "<Project Name>"
    env                             = "<Build Environment>"
    codebuild_role                  = "<CodeBuild Role>"
    build_compute_type              = "Build Specification"
    build_image                     = "<Image Environment"
    build_type                      = "<Build Environment>"
    build_privileged_mode           = "<true/false>"
    build_artifact                  = "<Build Output Artifact Type>" 
    cache_config                    = [
        {
            type                    = "<Cache Type>"
            location                = "<Cache Location>"
            modes                   = "<List of Caches modes>
        }
    ]
    codebuild_vpc_config            = [
        {
            vpc_id                  = "<VPC ID>"
            security_group_ids      = "<List of security groups>"
            subnets                 = "<List of Subnets>"
        }
    ]
    source_config                   = [
        {
            source_type             = "<Repository Type>"
            buildspec               = "<Build Spec YAML>"
            location                = "<Location of Repository>"s
        }
    ]
    codebuild_variables             = [
        {
            name    = "<Name of Variable>"
            value   = "<Value>"
        }
    ]
}
```

## Variables 

| Variables                 | Usage                         |Type           |
|---------------------------|-------------------------------|---------------|
|project(*)                 |The name of projet             |`String`       |
|env(*)                     |The environment name           |`String`       |
|codebuild_role             |The role for CodeBuild         |`String`       |
|build_compute_type         |Build Compute Type             |`String`       |
|build_image                |Build Image                    |`String`       |
|build_type                 |Build Type                     |`String`       |
|build_privileged_mode      |Whether to escalate previlege  |`Boolean`      |
|build_artifact             |Build Artifact Type            |`String`       |
|codebuild_vpc_config       |CodeBuild VPC Config           |`Map`          |
|cache_config               |CodeBuild Cache Config         |`Map`          |
|source_config              |CodeBuild Source Config        |`Map`          |
|codebuild_variables        |CodeBuild Variables            |`Map`          |

_(*) = required variable._

## Outputs

| output                    | Value                             |Type               |
|---------------------------|-----------------------------------|-------------------|
|codebuild_arn              |CodeBuild ARN                      |`String`           |