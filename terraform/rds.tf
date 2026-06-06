resource "random_password" "db_password" {
  length  = 16
  special = true
}


#DB Subnet Group

resource "aws_db_subnet_group" "main" {
  name = "${var.devops-assignment}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private.id
  ]

  tags = {
    Name = "${var.devops-assignment}-db-subnet-group"
  }
}

# PostgreSQL Database


resource "aws_db_instance" "postgres" {
  identifier             = "exercise-postgres"

  engine                 = "postgres"
  engine_version         = "16"

  instance_class         = "db.t3.micro"

  allocated_storage      = 20

  username               = "appuser"
  password               = random_password.db_password.result

  publicly_accessible    = false

  db_subnet_group_name   = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  skip_final_snapshot = true
}