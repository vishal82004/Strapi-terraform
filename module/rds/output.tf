output "endpoint" {
  description = "The RDS endpoint"
  value       = aws_db_instance.strapi_instance.endpoint
  
}
output "port" {
  description = "The RDS port"
  value       = aws_db_instance.strapi_instance.port
}
output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.strapi_instance.id
}
output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.strapi_instance.name
}
output "db_username" {
  description = "The master username for the database"
  value       = aws_db_instance.strapi_instance.username
}
output "db_security_group_id" {
  description = "The security group ID for the RDS instance"
  value       = aws_security_group.dbsg.id
}
output "db_subnet_group_name" {
  description = "The DB subnet group name"
  value       = aws_db_subnet_group.private_db_subnet.name
}
output "rds_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.strapi_instance.arn
}
output "rds_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.strapi_instance.id
}
output "ec2-sg" {
  description = "The security group ID for the EC2 instance"
  value       = aws_security_group.sg.id
}
