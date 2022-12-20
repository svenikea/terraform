resource "aws_codepipeline" "pipeline" {
    name            = var.name
    role_arn        = var.role_arn
    artifact_store {
      location      = var.location
      type          = "S3"
    }

    dynamic "stage" {
        for_each    = var.stages
        #for_each    = var.stages != null ? var.stages : []
        content {
            name    = stage.value.stage_name
            dynamic "action" {
                for_each                        =  stage.value.actions
                #for_each =  stage.value.actions != null ? stage.value.actions : []
                content {
                    name                        = action.value.action_name
                    category                    = action.value.category
                    owner                       = action.value.owner
                    provider                    = action.value.provider
                    version                     = lookup(action.value,"version", false) == false ? "1" : ( lookup(action.value,"version", false) != false )  ? action.value.version : "1"
                    input_artifacts             = action.value.category == "Deploy" || action.value.category == "Build" ? action.value.input_artifacts : null
                    output_artifacts            = action.value.category == "Source" || action.value.category == "Build" ? action.value.output_artifacts : null 
                    region                      = action.value.category == "Deploy" && ( action.value.provider == "S3" || action.value.provider == "CodeDeploy" || ( action.value.provider == "Lambda" && action.value.category == "Invoke" ) ) ? action.value.region : null
                    configuration = {
                        # Required parameters
                        ApplicationName         = action.value.provider == "ElasticBeanstalk" || action.value.provider == "CodeDeploy" ? action.value.application_name : null
                        EnvironmentName         = action.value.provider == "ElasticBeanstalk" ? action.value.environment_name : null
                        RepositoryName          = action.value.provider == "CodeCommit" ? action.value.repository_name : null
                        BranchName              = action.value.provider == "CodeCommit" ? action.value.branch_name : action.value.provider == "ECR" ? action.value.ecr_repository_name : null
                        ProjectName             = action.value.provider == "CodeBuild" ? action.value.project_name : null
                        ClusterName             = action.value.provider == "ECS" ? action.value.cluster_name : null
                        ServiceName             = action.value.provider == "ECS" ? action.value.service_name : null
                        DeploymentGroupName     = action.value.provider == "CodeDeploy" ? action.value.deployment_group_name : null
                        FunctionName            = action.value.provider == "Lambda" ? action.value.function_name : null
                      
                        # Optional parameters
                        EnvironmentVariables    = action.value.provider == "CodeBuild" && ( lookup(action.value,"environment_variables", false) == false ) ? null : ( action.value.provider == "CodeBuild" && ( lookup(action.value,"environment_variables", false) != false ) ) ? action.value.environment_variables : null
                        PrimarySource           = action.value.provider == "CodeBuild" && ( lookup(action.value,"primary_source", false) == false ) ? null : ( action.value.provider == "CodeBuild" && ( lookup(action.value,"primary_source", false) != false ) ) ? action.value.primary_source : null
                        CombineArtifacts        = action.value.provider == "CodeBuild" && ( lookup(action.value,"combine_artifacts", false) == false ) ? null : ( action.value.provider == "CodeBuild" && ( lookup(action.value,"combine_artifacts", false) != false ) ) ? action.value.combine_artifacts : null
                        BatchEnabled            = action.value.provider == "CodeBuild" && ( lookup(action.value,"batch_enabled", false) == false ) ? null : ( action.value.provider == "CodeBuild" && ( lookup(action.value,"batch_enabled", false) != false ) ) ? action.value.batch_enabled : null
                        FileName                = action.value.provider == "ECS" && ( lookup(action.value,"file_name", false) == false ) ? null : ( action.value.provider == "ECS" && ( lookup(action.value,"file_name", false) != false ) ) ? action.value.file_name : null
                        DeploymentTimeout       = action.value.provider == "ECS" && ( lookup(action.value,"deployment_timeout", false) == false ) ? null : ( action.value.provider == "ECS" && ( lookup(action.value,"deployment_timeout", false) != false ) ) ? action.value.deployment_timeout : null
                        S3Bucket                = action.value.provider == "ECS" && ( lookup(action.value,"s3_bucket", false) == false ) ? null : ( action.value.provider == "ECS" && ( lookup(action.value,"s3_bucket", false) != false ) ) ? action.value.s3_bucket : null                   
                        S3ObjectKey             = action.value.provider == "ECS" && ( lookup(action.value,"s3_object_key", false) == false ) ? null : ( action.value.provider == "ECS" && ( lookup(action.value,"s3_object_key", false) != false ) ) ? action.value.s3_object_key : null
                        ImageTag                = action.value.provider == "ECR" && ( lookup(action.value,"image_tag", false) == false ) ? null : ( action.value.provider == "ECR" && ( lookup(action.value,"image_tag", false) != false ) ) ? action.value.image_tag : null     
                        PollForSourceChanges    = action.value.category == "Deploy" && ( lookup(action.value,"poll_for_source_changes", false) == false ) ? null : ( action.value.category == "Deploy" && ( lookup(action.value,"poll_for_source_changes", false) != false ) ) ? action.value.poll_for_source_changes : null      
                        UserParameters          = action.value.provider == "Lambda" && ( lookup(action.value,"user_parameters", false) == false ) ? null : ( action.value.provider == "Lambda" && ( lookup(action.value,"user_parameters", false) != false ) ) ? action.value.user_parameters : null                    
                    }
                }
            }
        }
    }
    tags = {
        Name            = var.name
        EnvironmentName = var.env
        Terraform       = true
    }
}


