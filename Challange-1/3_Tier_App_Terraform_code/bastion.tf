
# Create a security group to allow traffic to Bastion server
resource "aws_security_group" "sg_bas" {
  name_prefix = "sg_bas"
  description = "Security group for baston server"
  vpc_id      = aws_vpc.three-tier.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }


 ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "sg_bas"
  }

}



####################BAS-1############################

# Create an EC2 instance
resource "aws_instance" "bas1" {
  ami           = "ami-0fc682b2a42e57ca2" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.sg_bas.id]
  user_data     = <<-EOF
                        <script>
                        net user Administrator "${var.winPass}"
                        </script>
                    EOF

  tags = {
    Name = "Baston-1"
  }
  }

#Public Elastic IP for instance so that we can access this server over internet. please use EIP to do RDP
resource "aws_eip" "eip_rec" {
  instance = aws_instance.bas1.id
}