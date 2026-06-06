[
  {
    "name": "api",
    "image": "nginxdemos/hello",
    "essential": true,

    "portMappings": [
      {
        "containerPort": 8080,
        "protocol": "tcp"
      }
    ],

    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/devops-assignment",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "api"
      }
    },

    "secrets": [
      {
        "name": "REDIS_HOST",
        "valueFrom": "/exercise/redis/host"
      }
    ]
  }
]
