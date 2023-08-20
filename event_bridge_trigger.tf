## create an event bucket notification
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification#emit-events-to-eventbridge
resource "aws_s3_bucket_notification" "data_uploaded_to_raw_bucket_notification" {
  bucket      = aws_s3_bucket.genai_data_raw.id
  eventbridge = true
}


resource "aws_cloudwatch_event_rule" "data_uploaded_s3_raw_notification_rule" {
  name           = "data-uploaded-s3-raw-notification-rule"
  description    = "Data uploaded to genai raw bucket S3 notification rule"
  event_bus_name = local.event_bus_name

  event_pattern = jsonencode(
    {
      "source" : ["aws.s3"],
      "detail-type" : ["Object Created"],
      "detail" : {
        "bucket" : {
          "name" : ["${aws_s3_bucket.genai_data_raw.bucket}"]
        }
      }
    }
  )
}

resource "aws_cloudwatch_event_target" "data_processing_lambda_function_target" {
  arn  = module.lambda_function.lambda_function_arn
  rule = aws_cloudwatch_event_rule.data_uploaded_s3_raw_notification_rule.id

  input_transformer {
    input_paths = {
      detail = "$.detail",
    }

    input_template = <<EOF
      {
        "details" : <detail>
      }
    EOF
  }
}