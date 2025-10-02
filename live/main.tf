module "eks_vpc" {
  source                     = "../modules/vpc"
  common_tags                = var.common_vars["common_tags"]
  environment                = var.common_vars["environment"]
  application_name           = var.common_vars["application_name"]
  vpc_cidr_block             = var.vpc["vpc_cidr_block"]
  public_subnet_cidr_blocks  = var.vpc["public_subnet_cidr_blocks"]
  availability_zone          = var.vpc["availability_zone"]
  private_subnet_cidr_blocks = var.vpc["private_subnet_cidr_blocks"]
  db_subnet_cidr_blocks      = var.vpc["db_subnet_cidr_blocks"]
  enable_nat_gateway         = var.vpc["enable_nat_gateway"]
  enable_vpc_flow_logs_cw    = var.vpc["enable_vpc_flow_logs_cw"]
}

module "acm_certificates" {
  source            = "../modules/acm"
  environment       = var.common_vars["environment"]
  project_name      = var.common_vars["application_name"]
  common_tags       = var.common_vars["common_tags"]
  zone_id           = var.common_vars["zone_id"]
  domain_names       = var.acm["domain_names"]
  validation_method = var.acm["validation_method"]
}