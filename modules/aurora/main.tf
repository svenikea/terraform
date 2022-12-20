resource "aws_rds_cluster" "aurora_cluster" {
    count                   = var.new_cluster == true ? 1 : 0
    cluster_identifier      = "aurora-cluster-${var.project}-${var.env}"
    engine                  = "aurora-${var.aurora_engine}"
    engine_version          = var.aurora_engine_version
    master_username         = var.aurora_user
    master_password         = random_string.aurora_password.result
    database_name           = var.aurora_database_name
    vpc_security_group_ids  = var.aurora_sg
    db_subnet_group_name    = aws_db_subnet_group.aurora_subnet.id
    skip_final_snapshot     = var.aurora_skip_final_snapshot
    backup_retention_period = var.aurora_backup_retention_period
    apply_immediately       = true
    tags = {
        Environment         = var.env
        Name                = "${var.project}-aurora-cluster-${var.env}"
        Terraform           = true
    }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
    count                   = var.new_cluster == true ? var.aurora_instance_number : 0
    identifier              = "${var.project}-aurora-${var.env}-${count.index+1}"
    cluster_identifier      = aws_rds_cluster.aurora_cluster.id
    instance_class          = "db.${var.aurora_instance_class}"
    engine                  = aws_rds_cluster.aurora_cluster.engine
    engine_version          = aws_rds_cluster.aurora_cluster.engine_version
    db_parameter_group_name = aws_db_parameter_group.aurora_parameter_group.name
    apply_immediately       = true
    tags = {
        Environment         = var.env
        Name                = "${var.project}-aurora-instance-${var.env}"
        Terraform           = true
    }
}

resource "aws_db_instance" "aurora_instance" {
    count                   = var_new_instance != false && var.aurora_instance_number != null ? length(var.aurora_instance_number) : 0 
    engine                  = "${var.aurora_engine}"
    engine_version          = var.aurora_engine_version
    instance_class          = "db.${var.aurora_instance_class}"
    identifier              = "database-${var.project}-${var.env}"
    db_name                 = var.aurora_database_name
    username                = var.aurora_user
    password                = random_string.aurora_password.result
    db_subnet_group_name    = aws_db_subnet_group.aurora_subnet.id
    parameter_group_name    = aws_db_parameter_group.aurora_parameter_group.name
    multi_az                = var.aurora_multi_az 
    vpc_security_group_ids  = var.aurora_sg
    storage_type            = var.aurora_storage_type
    backup_retention_period = var.aurora_backup_retention_period
    skip_final_snapshot     = var.aurora_skip_final_snapshot
    availability_zone       = var.aurora_availability_zone 
    tags = {
        Environment         = var.env
        Name                = "${var.project}-db-${var.env}"
        Terraform           = true
    }
}

resource "aws_db_subnet_group" "aurora_subnet" {
    name                    = "${var.project}-aurora-subnet-group-${var.env}"
    subnet_ids              = var.private_subnets
    tags = {
        Name                = "${var.project}-aurora-subnet-group-${var.env}"
    }
}

resource "random_string" "aurora_password" {
    length                  = var.random_string_length
    special                 = false

    depends_on = [
      aws_rds_cluster.aurora_cluster,
      aws_db_instance.aurora_instance
    ]
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
    name                    = "${var.project}-aurora-pg-${var.env}"
    family                  = var.new_cluster ? "aurora-${var.aurora_engine}5.7" : "${var.aurora_engine}5.7"
    dynamic "parameter" {
        for_each            = var.aurora_parameter_group
        content {
            name            = parameter.value.name
            value           = parameter.value.value 
        }
    }
    tags = {
        Environment         = var.env
        Name                = "${var.project}-pg-${var.env}"
        Terraform           = true
    }
}
