resource "random_string" "random_bucket_string_curated" {
  length  = 4
  special = false
}

## create a bucket to store final processed curated data
resource "aws_s3_bucket" "genai_data_curated" {
  bucket = format("%s-%s-%s-curated-%s", local.base_name, local.application_name, local.environment,
  lower(random_string.random_bucket_string_curated.id))
  force_destroy = true

  tags = {
    Environment = local.environment
  }
}
