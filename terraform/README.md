
# DevOps Exercise – ECS Fargate with PostgreSQL and Redis


## About the Project

This project provisions a simple microservices platform on AWS using Terraform.

There are three services running on ECS Fargate:

* **api** (Port 8080) – Publicly accessible through an Application Load Balancer
* **orders** (Port 8081) – Internal service
* **inventory** (Port 8082) – Internal service

The services share:

* One PostgreSQL database hosted on Amazon RDS
* One Redis instance hosted on Amazon ElastiCache

The API service is the only service exposed to the internet. Orders and Inventory remain private and can only be accessed within the VPC.

To avoid hardcoded credentials, database and Redis connection details are stored in AWS Systems Manager Parameter Store and injected into ECS tasks at runtime.

---

## Architecture

```text
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
        +--------+--------+
                 |
                 v

         PostgreSQL (RDS)

API ---------> Redis
Orders ------> Redis
Inventory ---> Redis
```

---

## AWS Services Used

* Amazon ECS Fargate
* Application Load Balancer (ALB)
* Amazon RDS PostgreSQL
* Amazon ElastiCache Redis
* AWS Systems Manager Parameter Store
* Amazon CloudWatch Logs
* Amazon VPC
* Security Groups

---

## Security

A basic least-privilege approach was followed:

* ALB accepts HTTP traffic from the internet.
* ECS services are only accessible through the ALB.
* PostgreSQL is only accessible from ECS services.
* Redis is only accessible from ECS services.
* No secrets are hardcoded in Terraform or container definitions.

---

## Deployment

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Review the execution plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

After deployment, Terraform outputs the ALB DNS name along with the RDS and Redis endpoints.

---

## Verification

Verify that the ECS services are running and healthy.

Test the API endpoint:

```bash
curl http://<alb_dns_name>
```

Check:

* ECS services are healthy
* ALB target group is healthy
* CloudWatch logs are being generated
* RDS is not publicly accessible
* Redis is not publicly accessible

---

## Cleanup

To remove all resources:

```bash
terraform destroy
```

---

## Assumptions

* Single AWS region
* Single Availability Zone
* Placeholder container image (`nginxdemos/hello`)
* No autoscaling configuration
* No CI/CD pipeline
* HTTP listener only
* Terraform used as the Infrastructure as Code tool

---



