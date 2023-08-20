locals {
  aws_region = var.aws_region

  base_name        = var.base_name
  application_name = var.application_name
  environment      = var.environment
  project          = "${var.base_name}-${var.application_name}-${var.environment}"

  all_cidr_block = "0.0.0.0/0"

  # vpc
  create_vpc = var.create_vpc
  vpc_name   = "${var.base_name}-${var.application_name}-${var.environment}-${var.vpc_name}"
  vpc_cidr   = var.vpc_cidr
  vpc_id     = var.vpc_id

  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  create_igw         = true
  enable_nat_gateway = true
  enable_vpn_gateway = false

  # eventbridge
  event_bus_name = var.event_bus_name

  # lambda
  lambda_function_name = "${var.base_name}-${var.application_name}-${var.environment}-${var.lambda_function_name}"

  #rds
  msssql_rds_name                  = "${var.base_name}-${var.application_name}-${var.environment}-${var.msssql_rds_name}"
  mssql_instance_class             = var.mssql_instance_class
  mssql_instance_allocated_storage = var.mssql_instance_allocated_storage
  mssql_database_name              = var.mssql_database_name
  mssql_username                   = var.mssql_username
  mssql_password                   = var.mssql_password
  mssql_port                       = var.mssql_port
  mssql_security_group_name        = "${var.base_name}-${var.application_name}-${var.environment}-${var.msssql_rds_name}-sg"

  # ecr
  registries = var.ecr_registries

  # ecs
  ecs_cluster_name                       = "${var.base_name}-${var.application_name}-${var.environment}-${var.ecs_cluster_name}"
  ecs_cluster_cloud_watch_log_group_name = "/aws/ecs/${var.base_name}/${var.application_name}/${var.environment}/${var.ecs_cluster_name}-logs"
  ecs_cluster_cpu_capacity               = var.ecs_cluster_cpu_capacity
  ecs_cluster_memory_capacity            = var.ecs_cluster_memory_capacity
}