# Create the VPC
resource "aws_vpc" "three-tier" {
  #cidr_block = "10.0.0.0/16"
  cidr_block = var.vpc_cidr
  tags = {
    Name = "3-tier app VPC"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.three-tier.id
}

# Create four subnets in different Availability Zones AZ
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.three-tier.id
  cidr_block = var.vpc_cidr-public1
  availability_zone = var.az1
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.three-tier.id
  cidr_block = var.vpc_cidr-private1
  availability_zone = var.az1
  tags = {
    Name = "private1"
  }
}


resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.three-tier.id
  cidr_block = var.vpc_cidr-public2
  availability_zone = var.az2
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.three-tier.id
  cidr_block = var.vpc_cidr-private2
  availability_zone = var.az2
  tags = {
    Name = "private1"
  }
}
