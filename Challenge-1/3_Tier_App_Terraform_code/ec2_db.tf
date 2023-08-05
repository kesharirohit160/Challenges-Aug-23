
# Create a security group to allow the traffic for SQL
resource "aws_security_group" "sg_sql" {
  name_prefix = "sg_sql"
  description = "Security group for App server"
  vpc_id      = aws_vpc.three-tier.id

ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]

  }

  ingress {
    from_port   = 3343
    to_port     = 3343
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_sql"
  }
  
}


####################SQL1############################

# Create the EBS volume
resource "aws_ebs_volume" "sql1_e" {
  availability_zone = var.az1  
  size              = 10 
  tags = {
    Name = "E Volume for sql1"
  }
}


# Create an EC2 instance
resource "aws_instance" "sql1" {
  ami           = "ami-0fc682b2a42e57ca2" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private1.id
  vpc_security_group_ids = [aws_security_group.sg_sql.id]
  user_data     = <<-EOF
                        <script>
                        net user Administrator "${var.winPass}"
                        </script>
                    EOF

  tags = {
    Name = "SQL-1"
  }

}


# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "sql1_e" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.sql1_e.id
  instance_id = aws_instance.sql1.id
}

####################SQl2############################

# Create the EBS volume
resource "aws_ebs_volume" "sql2_e" {
  availability_zone = var.az2 
  size              = 10 
  tags = {
    Name = "E Volume for sql2"
  }
}


# Create an EC2 instance
resource "aws_instance" "sql2" {
  ami           = "ami-0fc682b2a42e57ca2" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private2.id
  vpc_security_group_ids = [aws_security_group.sg_sql.id]
  user_data     = <<-EOF
                        <script>
                        net user Administrator "${var.winPass}"
                        </script>
                    EOF
  tags = {
    Name = "SQL-2"
  }
}
# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "sql2_e" {
  device_name = "/dev/sdf" 
  volume_id   = aws_ebs_volume.sql2_e.id
  instance_id = aws_instance.sql2.id
}