aws_region = "us-east-1"
common_vars = {
  environment = "dev"
  application_name = "eks"
  common_tags = {
    Environment = "development"
    ApplicationName = "eks"
    Owner = "konkas"
    Terraform = "true"
  }
  zone_id = "Z011675617HENPLWZ1EJC"
}
vpc = {
    vpc_cidr_block = "10.1.0.0/16"
    availability_zone = ["us-east-1a", "us-east-1b"]
    public_subnet_cidr_blocks = ["10.1.1.0/24","10.1.2.0/24"]
    private_subnet_cidr_blocks = ["10.1.11.0/24","10.1.12.0/24"]
    db_subnet_cidr_blocks = ["10.1.21.0/24","10.1.22.0/24"]
    enable_nat_gateway = false
    enable_vpc_flow_logs_cw = false
}

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

lb_acm = {
  domain_name       = "dev-expense.konkas.tech"
  validation_method = "DNS"
}


external_alb = {
  lb_name                   = "ingress-controller"
  enable_deletion_protection = false
  choose_internal_external   = false
  enable_zonal_shift         = false
  load_balancer_type         = "application"
  tg_port                    = 80
  health_check_path          = "/"
  enable_http                 = false
  enable_https                = true
  record_name                = "dev-expense.konkas.tech"
}
