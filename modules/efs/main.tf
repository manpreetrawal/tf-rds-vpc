#resource "aws_efs_file_system" "efs" {
#  creation_token = "gardeneur-efs"
#
#  tags = {
#    Name = "${var.name}-${var.environment}-efs"
#  }
#}
resource "aws_efs_file_system" "efs_with_lifecyle_policy" {
  creation_token = "${var.name}-${var.environment}-efs"
  tags = {
    Name = "${var.name}-${var.environment}-efs"
  }
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}
resource "aws_efs_access_point" "access_point" {
  file_system_id = aws_efs_file_system.efs_with_lifecyle_policy.id
  tags = {
    Name = "${var.name}-${var.environment}-efs"
  }
}
