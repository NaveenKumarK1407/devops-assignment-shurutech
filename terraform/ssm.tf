# DB Host

resource "aws_ssm_parameter" "db_host" {
  name  = "/exercise/db/host"
  type  = "String"

  value = aws_db_instance.postgres.address
}


# DB Username

resource "aws_ssm_parameter" "db_user" {
  name  = "/exercise/db/user"
  type  = "String"

  value = "appuser"
}

# DB Password

resource "aws_ssm_parameter" "db_password" {
  name  = "/exercise/db/password"
  type  = "SecureString"

  value = random_password.db_password.result
}

# Redis Host

resource "aws_ssm_parameter" "redis_host" {
  name  = "/exercise/redis/host"
  type  = "String"

  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}