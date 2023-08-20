module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  count = local.create_vpc ? 1 : 0

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs = local.availability_zones

  private_subnets      = local.private_subnet_cidrs
  private_subnet_names = [for i in range(length(local.private_subnet_cidrs)) : format("%s%02d", "Private-Subnet-", i)]

  public_subnets      = local.public_subnet_cidrs
  public_subnet_names = [for i in range(length(local.public_subnet_cidrs)) : format("%s%02d", "Public-Subnet-", i)]

  create_igw         = local.create_igw
  enable_nat_gateway = local.enable_nat_gateway
  enable_vpn_gateway = local.enable_vpn_gateway

  tags = {
    Environment = local.environment
  }
}

data "aws_vpc" "this" {
  id         = local.create_vpc ? module.vpc[0].vpc_id : local.vpc_id
  depends_on = [module.vpc]
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = {
    Name = "Private-Subnet-*"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = {
    Name = "Public-Subnet-*"
  }
}