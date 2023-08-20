resource "aws_security_group" "mssql_rds_sg" {
  name   = local.mssql_security_group_name
  vpc_id = data.aws_vpc.this.id

  ingress {
    from_port   = local.mssql_port
    to_port     = local.mssql_port
    protocol    = "tcp"
    cidr_blocks = [local.all_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.all_cidr_block]
  }
}

module "sqlserver_rds" {
  source = "terraform-aws-modules/rds/aws"

  create_db_instance = true
  identifier         = local.msssql_rds_name

  engine               = "sqlserver-web"
  engine_version       = "15.00"
  family               = "sqlserver-web-15.0"
  major_engine_version = "15.00"
  instance_class       = local.mssql_instance_class
  allocated_storage    = local.mssql_instance_allocated_storage
  license_model        = "license-included"
  storage_encrypted    = false

  db_name  = local.mssql_database_name
  username = local.mssql_username
  password = local.mssql_password
  port     = local.mssql_port

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.mssql_rds_sg.id]

  tags = {
    Environment = local.environment
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = data.aws_subnets.private.ids

  # Database Deletion Protection
  deletion_protection = false
}