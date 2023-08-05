#Region and AZs
variable "region" {
  default = "us-east-1"
}

variable "shortRegion" {
  default = "use1"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

#Default windows pass
variable "winPass" {
  default = "xyzPassword1!"
}

variable "winPass2" {
  default = "xyzPassword2!"
}


# -----------------------------------------------------
#    VPC and cidr block setups
# -----------------------------------------------------

#CIDR for VPC
variable "vpc_cidr" {
  default = "10.16.0.0/24"
}

#Public Subnet 1
variable "vpc_cidr-public1" {
  default = "10.16.0.0/27"
}

#Public Subnet 2
variable "vpc_cidr-public2" {
  default = "10.16.0.32/27"
}

#Private Subnet 1
variable "vpc_cidr-private1" {
  default = "10.16.0.64/27"
}

#Private Subnet 2
variable "vpc_cidr-private2" {
  default = "10.16.0.128/27"
}


