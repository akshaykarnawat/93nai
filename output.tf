output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "vpc_public_subnets" {
  value = data.aws_subnets.private.ids
}

output "vpc_private_subnets" {
  value = data.aws_subnets.public.ids
}

output "raw_bucket" {
  value = {
    "name" : "${aws_s3_bucket.genai_data_raw.bucket}"
    "arn" : "${aws_s3_bucket.genai_data_raw.arn}"
  }
}

output "curated_bucket" {
  value = {
    "name" : "${aws_s3_bucket.genai_data_curated.bucket}"
    "arn" : "${aws_s3_bucket.genai_data_curated.arn}"
  }
}

output "event_bridge_resource" {
  value = {
    "name" : "${aws_cloudwatch_event_rule.data_uploaded_s3_raw_notification_rule.name}"
    "arn" : "${aws_cloudwatch_event_rule.data_uploaded_s3_raw_notification_rule.arn}"
    "target_func" : "${aws_cloudwatch_event_target.data_processing_lambda_function_target.arn}"
  }
}

output "lambda_function" {
  value = {
    "name" : "${module.lambda_function.lambda_function_name}"
    "arn" : "${module.lambda_function.lambda_function_arn}"
  }
}

output "mssql_rds" {
  value = {
    "id" : module.sqlserver_rds.db_instance_resource_id
    "identifier" : module.sqlserver_rds.db_instance_identifier
    "arn" : module.sqlserver_rds.db_instance_arn
    "endpoint" : module.sqlserver_rds.db_instance_endpoint
    "database_name" : module.sqlserver_rds.db_instance_name
  }
}

output "repositories" {
  value = module.ecr[*]
}
