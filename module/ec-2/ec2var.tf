
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "instance_count" {
  description = "The number of EC2 instances to create"
  type        = number
  default     = module.vpc.public_subnet_ids != null ? length(module.vpc.public_subnet_ids) : 1
}

variable "ami_id" {
  description = "The ID of the AMI to use"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = list(string)
  default     = [module.vpc.public_subnet_ids]
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "my-instance"
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true

}

variable "key_name" {
  description = "The name of the key pair to use"
  type        = string
  default     = "deployer-key"
}

variable "public_key" {
  description = "The public key to use for the key pair"
  type        = string
  default     = module.ec2.public_key
}
variable "ADMIN_JWT_SECRET" {
  description = "Admin JWT Secret"
  type        = string
  default     = module.rds.admin_jwt_secret
  
}
variable "APP_KEYS" {
  description = "App Keys"
  type        = string
  default     = module.rds.app_keys
}
variable "API_TOKEN_SALT" {
  description = "API Token Salt"
  type        = string
  default     = module.rds.api_token_salt
}

variable "rds_endpoint" {
  description = "The RDS endpoint"
  type        = string
  default     = module.rds.endpoint
}
variable "rds_username" {
  description = "The RDS username"
  type        = string
  default     = module.rds.rds_username
}
variable "rds_password" {
  description = "The RDS password"
  type        = string
  default     = module.rds.rds_password
}
variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = module.vpc.aws_region
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = module.s3.s3_bucket_name
}
variable "AWS_SIGNED_URL_EXPIRATION" {
  type = number
  description = "Expiration time for signed URLs in seconds"
  default     = 3600
}
variable "AWS_ACL" {
  type = string
  description = "The ACL to apply to the S3 bucket"
  default     = "private"
  
}