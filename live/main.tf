######################################################################################
###############                    VPC                               #################
######################################################################################
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

######################################################################################
###############                    ACM                               #################
######################################################################################
module "acm" {
  source           = "../modules/acm"
  environment      = var.common_vars["environment"]
  project_name     = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  domain_names     = var.acm["domain_names"]
  validation_method = var.acm["validation_method"]
  zone_id          = var.common_vars["zone_id"]
}

######################################################################################
###############                    EKS CLuster                       #################
######################################################################################
module "eks_cluster" {
  source                     = "../modules/eks"
  environment = var.common_vars["environment"]
  project     = var.common_vars["application_name"]
  common_tags = var.common_vars["common_tags"]

  bootstrap_cluster_creator_admin_permissions = var.eks["bootstrap_cluster_creator_admin_permissions"]
  eks_version                                = var.eks["eks_version"]
  subnet_ids                                 = module.eks_vpc.public_subnet_ids
  security_group_ids                         = [module.controlplane.sg_id]
  endpoint_private_access                    = var.eks["endpoint_private_access"]
  endpoint_public_access                     = var.eks["endpoint_public_access"]
  public_access_cidrs                        = var.eks["public_access_cidrs"]
  node_groups                                = var.eks["node_groups"]
  node_group_security_group_ids              = [module.nodegroup.sg_id]
  node_subnet_ids = module.eks_vpc.public_subnet_ids
  enabled_cluster_log_types = var.eks["enabled_cluster_log_types"]
  addons = module.eks["addons"]
  # eks_iam_access = var.eks["eks_iam_access"]
}