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