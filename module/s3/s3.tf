
# Create a private S3 bucket for Strapi uploads
resource "aws_s3_bucket" "strapi_uploads" {
  bucket = var.bucket_name
}

# Block all public access to the bucket
resource "aws_s3_bucket_public_access_block" "strapi_uploads_public_access" {
  bucket = aws_s3_bucket.strapi_uploads.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create an IAM policy that allows access to the S3 bucket
resource "aws_iam_policy" "s3_access_policy" {
  name        = "strapi-s3-access-policy"
  description = "Allows EC2 to access the Strapi S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.strapi_uploads.arn}/*"
      }
    ]
  })
}

# Create an IAM role for the EC2 instance
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the S3 access policy to the role
resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Create an instance profile to attach the role to the EC2 instance
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}
# Create an IAM user for programmatic access (if needed)
resource "aws_iam_user" "s3_user" {
  name = "strapi-s3-user"
}