resource "aws_elasticache_subnet_group" "redis-subnet" {
  name       = "test-cache-subnet"
  subnet_ids = ["${var.private_subnet}"]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.name}-${var.environment}-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = 6379
  security_group_ids   = ["${var.security_group}"]
  subnet_group_name    = aws_elasticache_subnet_group.redis-subnet.name
}
