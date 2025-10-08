######################################################################################
###############                    Common Variables                  #################
######################################################################################
aws_region = "ap-south-1"
common_vars = {
  environment = "dev"
  application_name = "eks"
  common_tags = {
    Environment = "development"
    ApplicationName = "eks"
    Owner = "konkas"
    Terraform = "true"
  }
  zone_id = "Z03345832QRDQYLQ53NTN"
}
######################################################################################
###############                      VPC                             #################
######################################################################################
vpc = {
    vpc_cidr_block = "10.1.0.0/16"
    availability_zone = ["ap-south-1a", "ap-south-1b"]
    public_subnet_cidr_blocks = ["10.1.1.0/24","10.1.2.0/24"]
    private_subnet_cidr_blocks = ["10.1.11.0/24","10.1.12.0/24"]
    db_subnet_cidr_blocks = ["10.1.21.0/24","10.1.22.0/24"]
    enable_nat_gateway = false
    enable_vpc_flow_logs_cw = false
}

######################################################################################
###############                   Security Group                     #################
######################################################################################

sg = {
    bastion_sg_name = "bastion"
    bastion_sg_description = "Security Group for Bastion Host"

    vpn_sg_name = "vpn"
    vpn_sg_description = "Security Group for VPN"

    rds_sg_name = "rds"
    rds_sg_description = "Security Group for RDS"

    elasticache_sg_name = "elasticache"
    elasticache_sg_description = "Security Group for ElastiCache"

    controlplane_sg_name = "controlplane"
    controlplane_sg_description = "Security Group for Control Plane"

    nodegroup_sg_name = "nodegroup"
    nodegroup_sg_description = "Security Group for Node Group"

    external_alb_sg_name = "external_alb"
    external_alb_sg_description = "Security Group for External ALB"
}

######################################################################################
###############                   ACM Certificates                   #################
######################################################################################
acm = {
    domain_names = ["dev-expense.ullagallu.in", "dev-instana.ullagallu.in","dev-grafana.ullagallu.in", "dev-kibana.ullagallu.in","dev-argocd.ullagallu.in","dev-kiali.ullagallu.in","dev-jaeger.ullagallu.in"]
    validation_method = "DNS"
}

######################################################################################
###############                   EKS Cluster Parameters             #################
######################################################################################
eks = {
    bootstrap_cluster_creator_admin_permissions = true
    eks_version = "1.33"
    endpoint_private_access = true
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    node_groups = {
        base = {
            capacity_type = "ON_DEMAND"
            instance_types = ["t3a.medium"]
            desired_size = 2
            max_size     = 2
            min_size     = 2
        }
    }
}