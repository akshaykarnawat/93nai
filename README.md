# 93NAI

genai cloud infra poc


```terraform.tfvars
# terraform.tfvars

create_vpc = true

ecr_registries = [
  {
    repository_name                 = "api-01",
    repository_image_tag_mutability = "MUTABLE",
    repository_force_delete         = true
  },
  {
    repository_name                 = "api-02",
    repository_image_tag_mutability = "MUTABLE",
    repository_force_delete         = true
  }
]

msssql_rds_name                  = "sqlserver-rds"
mssql_instance_class             = "db.t3.small"
mssql_instance_allocated_storage = 20
mssql_database_name              = "genai-demodb"
mssql_username                   = "genai-rds-user"
mssql_password                   = "**redacted**"
mssql_port                       = "1433"
```