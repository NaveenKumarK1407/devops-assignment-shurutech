
# DevOps Exercise – ECS Fargate with PostgreSQL and Redis

This project provisions a simple microservices platform on AWS using Terraform.

The platform consists of three services running on ECS Fargate:

 Service   | Port | Public Access | Dependencies      |
 api       | 8080 | Yes (via ALB) | Redis             |
 orders    | 8081 | No            | PostgreSQL, Redis |
 inventory | 8082 | No            | PostgreSQL, Redis |

The API service is exposed to the internet through an Application Load Balancer, while Orders and Inventory remain internal services.

All services share:

 One PostgreSQL database hosted on Amazon RDS
 Redis instance hosted on Amazon ElastiCache




## Architecture

Internet
    |
    v
Application Load Balancer
    |
    v
API Service (ECS Fargate)
    |
    +------------------+
    |                  |
    v                  v
Orders Service    Inventory Service
(ECS Fargate)     (ECS Fargate)

        |                 |
    --------+--------+
                 |
                 v
  PostgreSQL (RDS)

API ---------> Redis
Orders ------> Redis
Inventory ---> Redis

## Components Used


 Amazon ECS Fargate
 ECS Cluster
 ECS Services
 ECS Task Definitions

# Networking

 VPC
 Public Subnet
 Private Subnet
 Internet Gateway
 Route Tables

# Load Balancing

 Application Load Balancer
 Target Group
 Listener

# Database

 Amazon RDS PostgreSQL

# Cache

 Amazon ElastiCache Redis

# Secrets

 AWS Systems Manager Parameter Store

# Monitoring

* Amazon CloudWatch Logs



## Security Design

The solution follows a basic least-privilege approach.

## ALB Security Group

 Allows HTTP traffic from the internet (Port 80)

### ECS Security Group

* Allows traffic only from the ALB

### RDS Security Group

* Allows PostgreSQL traffic (5432) only from ECS services

### Redis Security Group

* Allows Redis traffic (6379) only from ECS services





# Deployment

# Initialize Terraform:

terraform init

# Validate configuration:


terraform validate


# Review execution plan:


terraform plan

# Deploy infrastructure:


terraform apply




