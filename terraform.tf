# Note:
# Provide this value via a .tfvars file or environment variable.

#------------------------------------------------------------------------------
# General & AWS Variables
#------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
  
}
#------------------------------------------------------------------------------
# VPC Network Variables
#------------------------------------------------------------------------------

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
 

#------------------------------------------------------------------------------
# EC2 Instance Variables
#------------------------------------------------------------------------------

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}
variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
  default     = "strapi-ec2-instance"
}
variable "instance_count" {
  description = "The number of EC2 instances to launch"
  type        = number
  default     = 1
}
variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}
variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the EC2 instance"
  type        = bool
  default     = false
  
}
variable "public_key" {
  description = "The public key material for the SSH key pair"
  type        = string
  
}
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type in us-east-1
}
variable "ACL" {
  description = "The ACL for the S3 bucket"
  type        = string
  default     = "private"
  
}
variable "AWS_SIGNED_URL_EXPIRATION" {
  description = "The expiration time (in seconds) for signed URLs"
  type        = number
  default     = 900
}
variable "ADMIN_JWT_SECRET" {
  description = "Admin JWT Secret"
  type        = string
  sensitive   = true
}
variable "APP_KEYS" {
  description = "Application Keys"
  type        = string
  sensitive   = true
}
variable "API_TOKEN_SALT" {
  description = "API Token Salt"
  type        = string    
  sensitive   = true
}
#------------------------------------------------------------------------------
# RDS Database Variables
#------------------------------------------------------------------------------

variable "db_allocated_storage" {
  description = "The allocated storage in GB for the RDS instance"
  type        = number
  default     = 5
}
variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "strapidb"
}
variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}


variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "strapiadmin"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
  
}
variable "db_subnet_group_name" {
  description = "The subnet group name for the RDS instance"
  type        = list(string)    
  default     = ["private-db-subnet-group"]
} 
variable "db_instance_identifier" {
  description = "The DB instance identifier"
  type        = string
  default     = "strapi-rds-instance"
} 

#------------------------------------------------------------------------------
# S3 Bucket Variables
#------------------------------------------------------------------------------

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for Strapi uploads. Must be globally unique."
  type        = string
}
