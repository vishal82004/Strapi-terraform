output "s3_bucket_name" {   
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.strapi_uploads.bucket
}
output "ec2_role_name" {
  description = "The name of the IAM role for EC2"
  value       = aws_iam_role.ec2_s3_role.name
}
output "ec2_profile_name" {
  description = "The name of the IAM instance profile for EC2"
  value       = aws_iam_instance_profile.ec2_instance_profile.name
}
output "access_key" {
  description = "The access key ID for the IAM user"
  value       = aws_iam_access_key.s3_access_key.id
}
output "secret_key" {
  description = "The secret access key for the IAM user"
  value       = aws_iam_access_key.s3_access_key.secret 
}