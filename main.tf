module "vpc" {
  source = "./module/vpc"
  vpc_name = var.vpc_name
  availability_zones = var.availability_zones
  vpc_cidr = var.vpc_cidr
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs    
}
module "rds" {
  depends_on = [ module.vpc ]
  source = "./module/rds"
   db_instance_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_instance_class = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_subnet_group_name   = var.db_subnet_group_name
  db_instance_identifier = var.db_instance_identifier
  
}
 module "s3" {
  depends_on = [ module.vpc,  module.rds]
  source = "./module/s3"
  bucket_name = var.s3_bucket_name
   
 }
module "ec-2" {
  depends_on         = [module.vpc, module.rds, module.s3]
  source             = "./module/ec-2"
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.private_subnet_ids[*]
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  key_name           = var.key_name
  instance_count     = var.instance_count
  instance_name      = var.instance_name
  associate_public_ip = var.associate_public_ip
  public_key         = var.public_key
  ADMIN_JWT_SECRET   = var.ADMIN_JWT_SECRET
  APP_KEYS           = var.APP_KEYS
  API_TOKEN_SALT     = var.API_TOKEN_SALT
  rds_endpoint       = module.rds.endpoint
  rds_username       = module.rds.rds_username
  rds_password       = module.rds.rds_password
  aws_region         = var.aws_region
  s3_bucket_name     = var.s3_bucket_name
}