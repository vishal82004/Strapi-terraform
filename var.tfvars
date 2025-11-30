#------------------------------------------------------------------------------
# General & AWS Variables
#------------------------------------------------------------------------------
aws_region = "us-east-1"

#------------------------------------------------------------------------------
# VPC Network Variables
#------------------------------------------------------------------------------
vpc_name              = "my-vpc"
vpc_cidr              = "10.0.0.0/16"
availability_zones    = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs   = ["10.0.1.0/24"]
private_subnet_cidrs  = ["10.0.3.0/24"]

#------------------------------------------------------------------------------
# EC2 Instance Variables
#------------------------------------------------------------------------------
instance_type = "t3.micro"
ami_id        = "ami-0c02fb55956c7d316"
key_name      = "my-key-pair" # Replace with your actual key pair name
instance_count = 1  
instance_name  = "strapi-ec2-instance"
associate_public_ip = true
public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3..." # Replace with your actual public key
ADMIN_JWT_SECRET = "your-admin-jwt-secret" # Replace with a secure secret
APP_KEYS         = "your-app-keys"         # Replace with secure keys       
API_TOKEN_SALT   = "your-api-token-salt"   # Replace with a secure token salt


#------------------------------------------------------------------------------
# RDS Database Variables
#------------------------------------------------------------------------------
db_allocated_storage = 5
db_username          = "strapiadmin"
db_password          = "postgres"
db_name              = "strapidb"
db_instance_class   = "db.t3.micro"
db_instance_identifier = "strapi-rds-instance"
db_storage_type     = "gp2"
db_engine_version   = "13.4"
db_subnet_group_name = "private-db-subnet-group"
db_security_group_name = "rds-security-group"
ssh_cidr_blocks     = ["0.0.0.0/0"]



#------------------------------------------------------------------------------
# S3 Bucket Variables
#------------------------------------------------------------------------------
s3_bucket_name = "viunique-strapi-bucket-name" # Replace with a globally unique bucket name
