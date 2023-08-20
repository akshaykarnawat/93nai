module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  create        = true
  function_name = local.lambda_function_name
  description   = "Lambda function to trigger ETL/ELT APIs for data processing"
  handler       = "data_processing.lambda_handler"
  runtime       = "python3.9"
  timeout       = 900

  source_path = "functions/data_processing.py"

  environment_variables = {
    some_key = "some_value"
  }

  tags = {
    Name = local.lambda_function_name
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.data_uploaded_s3_raw_notification_rule.arn
}