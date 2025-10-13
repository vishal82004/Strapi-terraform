module "vpc" {
  source = "./module/vpc"
  vpc_name = var.vpc_name
  availability_zones = var.availability_zones
  vpc_cidr = var.vpc_cidr
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs    
}
module "rds" {
  source = "./module/rds"
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_instance_class = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_subnet_group_name   = var.db_subnet_group_name
  db_instance_identifier = var.db_instance_identifier
  
}