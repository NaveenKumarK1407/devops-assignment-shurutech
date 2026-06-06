

# ALB DNS Name


output "alb_dns_name" {
  value = aws_lb.api.dns_name
}


# RDS Endpoint

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}


# Redis Endpoint


output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}