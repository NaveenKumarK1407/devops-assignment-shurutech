[
  {
    "name": "orders",
    "image": "nginxdemos/hello",
    "essential": true,

    "portMappings": [
      {
        "containerPort": 8081,
        "protocol": "tcp"
      }
    ],

    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/devops-assignment",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "orders"
      }
    },

    "secrets": [
      {
        "name": "DB_HOST",
        "valueFrom": "/exercise/db/host"
      },
      {
        "name": "DB_PASSWORD",
        "valueFrom": "/exercise/db/password"
      },
      {
        "name": "REDIS_HOST",
        "valueFrom": "/exercise/redis/host"
      }
    ]
  }
]
