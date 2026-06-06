[
  {
    "name": "inventory",
    "image": "nginxdemos/hello",
    "essential": true,

    "portMappings": [
      {
        "containerPort": 8082,
        "protocol": "tcp"
      }
    ],

    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/devops-assignment",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "inventory"
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
