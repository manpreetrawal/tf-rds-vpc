output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}
output "rds_id" {
  value = aws_db_instance.db.id
}

