
# Create a security group to allow traffic for APP server
resource "aws_security_group" "sg_app" {
  name_prefix = "sg_app"
  description = "Security group for App server"
  vpc_id      = aws_vpc.three-tier.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }


 ingress {
    from_port   = 3389
    to_port     = 3389
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
    Name = "sg_app"
  }

}



####################App1############################

# Create the EBS volume
resource "aws_ebs_volume" "app1_e" {
  availability_zone = var.az1 
  size              = 10 
  tags = {
    Name = "E Volume for app1"
  }
}

# Create an EC2 instance
resource "aws_instance" "app1" {
  ami           = "ami-0fc682b2a42e57ca2" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private1.id
  vpc_security_group_ids = [aws_security_group.sg_app.id]
  user_data     = <<-EOF
                        <script>
                        net user Administrator "${var.winPass}"
                        </script>
                    EOF

  tags = {
    Name = "APP-1"
  }
  }
# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "app1_e" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.app1_e.id
  instance_id = aws_instance.app1.id
}

####################App2############################

# Create the EBS volume
resource "aws_ebs_volume" "app2_e" {
  availability_zone = var.az2 
  size              = 10 
  tags = {
    Name = "E Volume for app2"
  }
}


# Create an EC2 instance
resource "aws_instance" "app2" {
  ami           = "ami-0fc682b2a42e57ca2" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private2.id
  vpc_security_group_ids = [aws_security_group.sg_app.id]
  user_data     = <<-EOF
                        <script>
                        net user Administrator "${var.winPass}"
                        </script>
                    EOF
  tags = {
    Name = "APP-2"
  }
}
# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "app2_e" {
  device_name = "/dev/sdf" 
  volume_id   = aws_ebs_volume.app2_e.id
  instance_id = aws_instance.app2.id
}


####################################ALB#####################

