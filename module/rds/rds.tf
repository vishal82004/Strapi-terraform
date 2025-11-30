resource "aws_security_group" "sg" {
    name        = var.security_group_name
    description = "Security group for EC2 instance"
    vpc_id      = module.vpc.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.ssh_cidr_blocks
    }
    ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    }
resource "aws_db_subnet_group" "private_db_subnet" {
  name       = "private-db-subnet-group"
  subnet_ids = module.vpc.private_subnet_ids
    description = "Subnet group for private RDS instance"

  tags = {
    Name = "private-db-subnet-group"
  }
}
resource "aws_security_group" "dbsg" {
    depends_on = [ aws_security_group.sg ]
    name        = var.db_security_group_name
    description = "Security group for RDS instance"
    vpc_id      = module.vpc.vpc_id
    
    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        security_groups = [aws_security_group.sg.id]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
resource "aws_db_instance" "rds" {
  depends_on = [ aws_db_subnet_group.private_db_subnet ]
  identifier         = var.db_instance_identifier
  engine            = "postgres"
  username          = var.db_username
  password          = var.db_password
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage  = var.db_allocated_storage
  storage_type      = var.db_storage_type
  db_subnet_group_name = aws_db_subnet_group.private_db_subnet.name
  multi_az          = var.multi_az
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.dbsg.id]

  tags = {
    Name = var.db_instance_name
  }
}