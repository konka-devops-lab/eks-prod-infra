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

module "alb_acm" {
  source            = "../modules/acm"
  environment       = var.common_vars["environment"]
  project_name      = var.common_vars["application_name"]
  common_tags       = var.common_vars["common_tags"]
  zone_id           = var.common_vars["zone_id"]
  domain_name       = var.lb_acm["domain_name"]
  validation_method = var.lb_acm["validation_method"]
}



module "external-alb" {
  depends_on                 = [module.alb_acm]
  source                     = "../modules/elb"
  environment                = var.common_vars["environment"]
  project_name               = var.common_vars["application_name"]
  common_tags                = var.common_vars["common_tags"]
  security_groups            = [module.external_alb.sg_id]
  subnets                    = module.eks_vpc.public_subnet_ids
  vpc_id                     = module.eks_vpc.vpc_id
  lb_name                    = var.external_alb["lb_name"]
  enable_deletion_protection = var.external_alb["enable_deletion_protection"]
  choose_internal_external   = var.external_alb["choose_internal_external"]
  load_balancer_type         = var.external_alb["load_balancer_type"]
  enable_zonal_shift         = var.external_alb["enable_zonal_shift"]
  tg_port                    = var.external_alb["tg_port"]
  health_check_path          = var.external_alb["health_check_path"]
  enable_http                = var.external_alb["enable_http"]
  enable_https               = var.external_alb["enable_https"]
  certificate_arn            = module.alb_acm.certificate_arn
  zone_id                    = var.common_vars["zone_id"]
  record_name                = var.external_alb["record_name"]
}