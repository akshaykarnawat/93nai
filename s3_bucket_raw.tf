resource "random_string" "random_bucket_string_raw" {
  length  = 4
  special = false
}

## create a bucket to store unstructured data
resource "aws_s3_bucket" "genai_data_raw" {
  bucket = format("%s-%s-%s-raw-%s", local.base_name, local.application_name, local.environment,
  lower(random_string.random_bucket_string_raw.id))
  force_destroy = true

  tags = {
    Environment = local.environment
  }
}
