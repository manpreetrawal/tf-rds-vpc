################################################
# Create database subnet group
###############################################

resource "aws_db_subnet_group" "rds" {
  name       = "${var.name}-${var.environment}-subnet-group"
  subnet_ids = var.private_subnets
}

################################################
# Create database security group
###############################################

resource "aws_security_group" "rds_sg" {
  name         = "${var.name}-${var.environment}-subnet-group"
  description  = "Allow inbound traffic"
  vpc_id          = var.vpc_id

  ingress {
    description   = "PostgresSQL from VPC"
    from_port     = 5432
    to_port       = 5432
    protocol      = "tcp"
    cidr_blocks   = [var.vpc_cidr_block]
  }

   egress {
    from_port     = "0"
    to_port       = "0"
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }
 }

################################################
# Create database
###############################################


resource "aws_db_instance" "db" {
  identifier                   = "${var.name}-${var.environment}-db"
  allocated_storage            = var.rds_min_storage
  max_allocated_storage        = var.rds_max_allocated_storage
  multi_az                     = var.rds_enable_multi_az
  engine                       = "mysql"
  engine_version               = var.rds_mysql_version
  instance_class               = var.rds_instance_type
  name                         = "mydb"
  username                     = "admin"
  password                     = "admin123"
  parameter_group_name         = "default.mysql5.7"
  skip_final_snapshot          = true
  vpc_security_group_ids       = [aws_security_group.rds_sg.id]
  db_subnet_group_name         = aws_db_subnet_group.rds.name
}
