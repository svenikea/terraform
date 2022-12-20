# CodePipeline Module

This module will create CodePipeline for CodeCommit or any other services in AWS

## Terraform definition

```terraform
module "<module name>" {
    source                              = "../modules/codepipeline"
    role_arn                            = "<CodePipeline ARN Role>"
    name                                = "<CodePipeline Name>"  
    location                            = "<S3 Bucket>"
    env                                 = "<Environment for tagging>"
    stages                              = [
        {
            stage_name                  = "<Stage Name>"
            actions                     = [
                {
                    action_name         = "<Aciton Name>"
                    category            = "<Catergory Name>"
                    owner               = "<Cloud/Source Provider>"
                    provider            = "Provider Service"
                    output_artifacts    = ["<Name of the Output>"]
                    .
                    .
                    .
                },
                .
                .
                .
            ] 
        },
        {
            stage_name                  = "<Stage Name>"
            actions                     = [
                {
                    action_name         = "<Aciton Name>"
                    category            = "<Catergory Name>"
                    owner               = "<Cloud/Source Provider>"
                    provider            = "Provider Service"
                    output_artifacts    = ["<Name of the Output>"]
                    .
                    .
                    .
                },
                .
                .
                .
            ]
        }
    ]
}
```

## Variables 

| Variables             | Usage                             |   
|-----------------------|-----------------------------------|
|role_arn(*)            |An appropriate CodePipeline role   |
|name(*)                |The name of Pipeline               |
|location(*)            |S3 Bucket name                     |
|env(*)                 |Environment for CodePipeline       |
|stages(*)              |An Object block of multiple stages |
|action_name(*)         |The name of the action             |
|category(*)            |Valid values: Build, Source, Deploy|
|owner(*)               |Cloud Service owner                |
|output_artifacts(?)    |Output of a successful action      |
|input_artifacts(?)     |Input of the next action           |

_(*) = required variable._
_(?) = conditional variable._

# References

* The stage of codepipeline requires atleast 2 stages block, one for Source and the other is Deploy or Build

* Every environment has it own pipeline

## Code Logics and additional info

* [Conditional deciding fields of content in dynamic block](https://stackoverflow.com/a/69466297)

* [Literal if-elif-else condition](https://stackoverflow.com/a/64576657)

* [action structures](https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference.html)