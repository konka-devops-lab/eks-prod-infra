#################################################################
###                     VPC Outputs                           ###
#################################################################
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.eks_vpc.vpc_id
}
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.eks_vpc.public_subnet_ids
}
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.eks_vpc.private_subnet_ids
}
output "db_subnet_ids" {
  description = "List of DB subnet IDs"
  value       = module.eks_vpc.db_subnet_ids
}
output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = module.eks_vpc.db_subnet_group_name
}

#################################################################
###                     SG ID's                               ###
#################################################################
output "bastion_sg_id" {
  description = "Security Group ID for Bastion Host"
  value       = module.bastion.sg_id
}
output "vpn_sg_id" {
  description = "Security Group ID for VPN"
  value       = module.vpn.sg_id
}
output "rds_sg_id" {
  description = "Security Group ID for RDS"
  value       = module.rds.sg_id
}
output "elasticache_sg_id" {
  description = "Security Group ID for ElastiCache"
  value       = module.elasticache.sg_id
}
output "controlplane_sg_id" {
  description = "Security Group ID for Control Plane"
  value       = module.controlplane.sg_id
}
output "nodegroup_sg_id" {
  description = "Security Group ID for Node Group"
  value       = module.nodegroup.sg_id
}
output "external_alb_sg_id" {
  description = "Security Group ID for External ALB"
  value       = module.external_alb.sg_id
}


output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = module.alb_acm.certificate_arn
}