variable "db_subnet_group_name" {
  description = "The subnet group name for the RDS instance"
  type        = list(string)    
  
}
variable "db_instance_identifier" {
  description = "The DB instance identifier"
  type        = string
}
variable "db_instance_name" {
  description = "The name of the RDS instance"
  type        = string
  default     = "my-rds-instance"
}   
variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin"
}   
variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  default     = "YourPassword123!"
}
variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "13.4"
}
variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}
variable "db_allocated_storage" {
  description = "The allocated storage in GB for the RDS instance"
  type        = number
  default     = 5
}
variable "db_storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
  default     = "gp2"
}
variable "multi_az" {
  description = "Whether to create a Multi-AZ RDS instance"
  type        = bool
  default     = false
}
variable "db_security_group_name" {
  description = "The name of the security group for the RDS instance"
  type        = string
  default     = "rds-security-group"
}
variable "ssh_cidr_blocks" {
  description = "The CIDR blocks for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "my-security-group"
}
