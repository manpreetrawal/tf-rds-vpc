################################################
# Create apb
###############################################

resource "aws_lb" "loadbalancer" {
  name               = "${var.name}-${var.environment}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = var.public_subnets
  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}
