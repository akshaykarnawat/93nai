module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  count = length(local.registries)

  repository_name                 = local.registries[count.index].repository_name
  repository_image_tag_mutability = local.registries[count.index].repository_image_tag_mutability
  repository_force_delete         = local.registries[count.index].repository_force_delete
  repository_encryption_type      = "AES256"

  tags = {
    Environment = local.environment
  }
}