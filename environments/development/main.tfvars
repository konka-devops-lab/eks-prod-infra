aws_region = "us-east-1"
common_variables = {
  environment = "dev"
  application_name = "eks"
  common_tags = {
    Environment = "development"
    ApplicationName = "eks"
    Owner = "konkas"
    Terraform = "true"
  }
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