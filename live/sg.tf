module "bastion" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["bastion_sg_name"]
  sg_description   = var.sg["bastion_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}

module "vpn" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["vpn_sg_name"]
  sg_description   = var.sg["vpn_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}
module "rds" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["rds_sg_name"]
  sg_description   = var.sg["rds_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}

module "elasticache" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["elasticache_sg_name"]
  sg_description   = var.sg["elasticache_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}
module "controlplane" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["controlplane_sg_name"]
  sg_description   = var.sg["controlplane_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}
module "nodegroup" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["nodegroup_sg_name"]
  sg_description   = var.sg["nodegroup_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}
module "external_alb" {
  source           = "../modules/sg"
  environment      = var.common_vars["environment"]
  application_name = var.common_vars["application_name"]
  common_tags      = var.common_vars["common_tags"]
  sg_name          = var.sg["external_alb_sg_name"]
  sg_description   = var.sg["external_alb_sg_description"]
  vpc_id           = module.eks_vpc.vpc_id
}

# Bastion SG Rules
resource "aws_security_group_rule" "example" {
  type              = "ingress"
  description       = "Allow SSH access from anywhere"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# VPN SG Rules
resource "aws_security_group_rule" "vpn_ssh" {
  description       = "This rule allows all traffic from internet on 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_https" {
  description       = "This rule allows all traffic from internet on 443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_et" {
  description       = "This rule allows all traffic from internet on 943"
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_udp" {
  description       = "This rule allows all traffic from internet on 1194"
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

# RDS SG Rules
resource "aws_security_group_rule" "nodegroup_rds" {
  description              = "This rule allows all traffic from nodegroup to rds on 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.nodegroup.sg_id
  security_group_id        = module.rds.sg_id
}

resource "aws_security_group_rule" "vpn_rds" {
  description              = "This rule allows all traffic from vpn to rds on 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.rds.sg_id
}
resource "aws_security_group_rule" "bastion_rds" {
  description              = "This rule allows all traffic from bastion to rds on 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.rds.sg_id
}

# ElastiCache SG Rules
resource "aws_security_group_rule" "nodegroup_elasticache" {
  description              = "This rule allows all traffic from nodegroup to elasticache on 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.nodegroup.sg_id
  security_group_id        = module.elasticache.sg_id
}

resource "aws_security_group_rule" "vpn_elasticache" {
  description              = "This rule allows all traffic from vpn to elasticache on 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.elasticache.sg_id
}
resource "aws_security_group_rule" "bastion_elasticache" {
  description              = "This rule allows all traffic from bastion to elasticache on 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.elasticache.sg_id
}

# Control Plane SG Rules
resource "aws_security_group_rule" "external_controlplane" {
  description       = "This rule allows all traffic from external to controlplane on 443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.controlplane.sg_id
}
resource "aws_security_group_rule" "nodegroup_controlplane" {
  description              = "This rule allows all traffic from nodegroup to controlplane"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.nodegroup.sg_id
  security_group_id        = module.controlplane.sg_id
}

# Node Group SG Rules
resource "aws_security_group_rule" "controlplane_nodegroup" {
  description              = "This rule allows all traffic from controlplane to nodegroup"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.controlplane.sg_id
  security_group_id        = module.nodegroup.sg_id
}
resource "aws_security_group_rule" "nodegroup_self" {
  description       = "This rule allows all traffic from nodegroup itself"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = module.nodegroup.sg_id
}
resource "aws_security_group_rule" "alb_nodegroup" {
  description              = "This rule allows all traffic from alb nodegroup on nodeport range"
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 32767
  protocol                 = "tcp"
  source_security_group_id = module.external_alb.sg_id
  security_group_id        = module.nodegroup.sg_id
}
resource "aws_security_group_rule" "http_alb" {
  description       = "This rule allows all traffic from internet to alb on port 80"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.external_alb.sg_id
}
resource "aws_security_group_rule" "https_alb" {
  description       = "This rule allows all traffic from internet to alb on port 443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.external_alb.sg_id
}