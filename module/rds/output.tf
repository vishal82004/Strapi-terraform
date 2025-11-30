output "endpoint" {
  description = "The RDS endpoint"
  value       = aws_db_instance.rds.endpoint
  
}
output "port" {
  description = "The RDS port"
  value       = aws_db_instance.rds.port
}
output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.rds.id
}
output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.rds.name
}
output "db_username" {
  description = "The master username for the database"
  value       = aws_db_instance.rds.username
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
  value       = aws_db_instance.rds.arn
}
output "rds_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.rds.id
}
output "ec2-sg" {
  description = "The security group ID for the EC2 instance"
  value       = aws_security_group.sg.id
}
