###############################################################################
# Variables
###############################################################################
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "base_name" {
  type        = string
  description = "Base project or company name"
  default     = "ak"
}

variable "application_name" {
  type        = string
  description = "Application name"
  default     = "genai"
}

variable "environment" {
  type        = string
  description = "Cloud environment. Example: dev, test, qa, uat, prod"
  default     = "dev"
}

###############################################################################
# Virtual Private Cloud
###############################################################################
variable "create_vpc" {
  type        = bool
  description = "Create a VPC or not"
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to use if create_vpc is false"
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR value"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}


###############################################################################
# Eventbridge
###############################################################################
variable "event_bus_name" {
  type        = string
  description = "Event Bus name to use"
  default     = "default"
}

###############################################################################
# Lambda
###############################################################################
variable "lambda_function_name" {
  type        = string
  description = "Lambda function name"
  default     = "data-processing"
}


###############################################################################
# ECR
###############################################################################
variable "ecr_registries" {
  type        = list(map(any))
  description = "Elastic Container Registries"
  default     = [{}]
}


###############################################################################
# RDS
###############################################################################
variable "msssql_rds_name" {
  type        = string
  description = "RDS MS SQL instance name"
  default     = "sqlserver-rds"
}

variable "mssql_instance_class" {
  type        = string
  description = "RDS MS SQL instance class"
  default     = "db.t3.small"
}

variable "mssql_instance_allocated_storage" {
  type        = number
  description = "RDS MS SQL instance allocated storage space"
  default     = 20
}

variable "mssql_database_name" {
  type        = string
  description = "RDS MS SQL database name"
  default     = "genai-demodb"
}

variable "mssql_username" {
  type        = string
  description = "RDS MS SQL username"
  default     = "genai-rds-user"
}

variable "mssql_password" {
  type        = string
  description = "RDS MS SQL password"
  default     = "9enai$foobarbaz"
}

variable "mssql_port" {
  type        = string
  description = "RDS MS SQL port"
  default     = "1433"
}