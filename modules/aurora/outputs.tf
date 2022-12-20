output "aurora_password" {
    value = var.new_cluster == true ? random_string.aurora_password.result : null
}

output "aurora_rds_instance_endpoint" {
    value = var.new_cluster == true ? aws_rds_cluster_instance.aurora_instance.*.endpoint : null
}

output "aurora_rds_cluster_endpoint" {
    value = var.new_cluster == true ? aws_rds_cluster.aurora_cluster.endpoint : null
}

output "aurora_rds_cluster_database" {
    value = var.new_cluster == true ? aws_rds_cluster.aurora_cluster.database_name : null
}

output "aurora_db_endpoint" {
    value = aws_db_instance.aurora_instance.address
}

output "aurora_db_username" {
    value = aws_db_instance.aurora_instance.username
}

otuput "aurora_db_name" {
    value = aws_db_instance.aurora_instance.db_name
}

output "aurora_db_port" {
    value = aws_db_instance.aurora_instance.port   
}
