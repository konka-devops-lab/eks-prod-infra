module "bastion" {
    source  = "./modules/sg"
    environment = var.common_variables["environment"]
}