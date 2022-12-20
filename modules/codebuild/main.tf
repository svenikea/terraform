resource "aws_codebuild_project" "build_project" {
    name                            = "${var.project}-${var.env}"
    description                     = "${var.project}-${var.env} Build Project" 
    build_timeout                   = "10"
    service_role                    = var.codebuild_role
    artifacts {
        type                        = var.build_artifact
    }   
    environment {
        compute_type                = var.build_compute_type
        image                       = var.build_image
        privileged_mode             = var.build_privileged_mode
        type                        = var.build_type
        dynamic "environment_variable" {
            for_each                = var.codebuild_variables != null ? var.codebuild_variables : []
            content {
                name                = environment_variable.value.name
                value               = environment_variable.value.value
            }
        }
    }
    dynamic "source" {
        for_each                    = var.source_config != null ? var.source_config : []
        content {
            type                    = source.value.source_type
            buildspec               = source.value.buildspec
            git_clone_depth         = 0
            location                = source.value.source_type != "CODEPIPELINE" ? source.value.location : null
            insecure_ssl            = false
            report_build_status     = false
        }
    }
    dynamic "vpc_config" {
        for_each                    = var.codebuild_vpc_config != null ? var.codebuild_vpc_config : []
        content {
            vpc_id                  = vpc_config.value.vpc_id
            security_group_ids      = vpc_config.value.security_group_ids
            subnets                 = vpc_config.value.subnets
        }
    }
    dynamic "cache" {
        for_each                    = var.cache_config != null ? var.cache_config : []
        content {
            type                    = cache.value.type
            location                = cache.value.type == "S3" ? cache.value.location : null
            modes                   = cache.value.type == "LOCAL" ? cache.value.modes : null
        }
    }
    tags = {
        Name                        = var.project
        Environment                 = var.env
        Terraform                   = true
    }
}

resource "aws_s3_object" "cache_folder" {
    count                           = lookup(var.cache_config[0], "type") == "S3" ? 1 : 0
    bucket                          = lookup(var.cache_config[0], "bucket_id")
    acl                             = "private"
    key                             = "${var.project}-${var.env}/${var.env}-cache/"
    content_type                    = "application/x-directory"
}