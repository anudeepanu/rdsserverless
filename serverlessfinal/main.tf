resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "indev-dem-aurora-psql"
  engine                  = var.engine
  engine_version        = var.engine_version
  engine_mode        = "provisioned"
  #instance_class     = "db.r6i.large"
  db_subnet_group_name = aws_db_subnet_group.default.id
  availability_zones      = [ "ap-south-1a", "ap-south-1b"]
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  network_type = "IPV4"
  port = 5432
  vpc_security_group_ids = ["sg-04b7ab5a21ae0e7d9"]
  skip_final_snapshot = "true"
  enabled_cloudwatch_logs_exports = ["postgresql"]
  allow_major_version_upgrade = "true"
  enable_http_endpoint = "true"
  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }


   tags = {
    Name = "aurora_postgres"
  }
}



resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  engine             = var.engine
  engine_version     = var.engine_version
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.serverless"
  db_subnet_group_name = aws_db_subnet_group.default.id
  monitoring_interval = 60
  monitoring_role_arn= aws_iam_role.aurora_monitoring_role.arn
  performance_insights_enabled = true
  performance_insights_retention_period = 7

}

resource "aws_db_subnet_group" "default" {
  name       = "db-subnet"
  subnet_ids = ["subnet-01441175846659b4d", "subnet-08bdc67b4ea7b21da"]

  tags = {
    Name = "My DB subnet group"
  }
}


output "database_name"{
   value= var.database_name
}

output "master_username"{
   value= var.master_username
}
#output "aurora_cluster_endpoint" {
   #value = aws_rds_cluster_instance.cluster_instances[0].endpoint

#}

output "aurora_cluster_endpoint" {
   value = aws_rds_cluster.postgresql.endpoint

}

output "master_password"{
   value= var.master_password
}

