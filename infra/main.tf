module "eks_vpc" {
  source = "./modules/vpc"
  common_tags = var.common_variables["common_tags"]
  environment = var.common_variables["environment"]
  application_name = var.common_variables["application_name"]
  vpc_cidr_block = var.vpc["vpc_cidr_block"]
  public_subnet_cidr_blocks = var.vpc["public_subnet_cidr_blocks"]
  availability_zone = var.vpc["availability_zone"]
  private_subnet_cidr_blocks = var.vpc["private_subnet_cidr_blocks"]
  db_subnet_cidr_blocks = var.vpc["db_subnet_cidr_blocks"]
  enable_nat_gateway = var.vpc["enable_nat_gateway"]
  enable_vpc_flow_logs_cw = var.vpc["enable_vpc_flow_logs_cw"]
}