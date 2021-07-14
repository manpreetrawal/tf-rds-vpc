data "aws_availability_zones" "available_zones"{
  state = "available"
 }

locals {

   public_subnets_cidr = [
      cidrsubnet(var.vpc_cidr_block, var.subnet_newbits, 0),
      cidrsubnet(var.vpc_cidr_block, var.subnet_newbits, 1)
   ]

   private_subnets_cidr = [
      cidrsubnet(var.vpc_cidr_block, var.subnet_newbits, 2),
      cidrsubnet(var.vpc_cidr_block, var.subnet_newbits, 3)
   ]
   
   availability_zones = [
     data.aws_availability_zones.available_zones.names[0],
     data.aws_availability_zones.available_zones.names[1]
   ]
  }

#######################################
#Create VPC
#######################################

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

#######################################
#Create Public Subnet
#######################################


resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnets_cidr[0]
  availability_zone       = local.availability_zones[0]
  tags = {
    Name        = "${var.environment}-public-subnet-{local.availability_zones[0]}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnets_cidr[1]
  availability_zone       = local.availability_zones[1]
  tags = {
    Name        = "${var.environment}-public-subnet-{local.availability_zones[1]}"
    Environment = "${var.environment}"
  }
}


#######################################
#Create Private Subnet
#######################################


resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.private_subnets_cidr[0]
  availability_zone       = local.availability_zones[0]
  tags = {
    Name        = "${var.environment}-private-subnet-{local.availability_zones[0]}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.private_subnets_cidr[1]
  availability_zone       = local.availability_zones[1]
  tags = {
    Name        = "${var.environment}-private-subnet-{local.availability_zones[1]}"
    Environment = "${var.environment}"
  }
}

#######################################
#Create Internet Gateway
#######################################

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

#################################################################
# Assigning public subnets to default route table and route for internet gateway
#################################################################


resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id          = aws_subnet.public_subnet_1.id
  route_table_id     = aws_vpc.vpc.default_route_table_id
  }

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id          = aws_subnet.public_subnet_2.id
  route_table_id     = aws_vpc.vpc.default_route_table_id
  }

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
  cidr_block = "0.0.0.0/0"
  gateway_id         = aws_internet_gateway.gw.id
}
   tags = {
    Name        = "${var.environment}-public-route-table"
  }
}


#######################################
#Create NAT Gateway
#######################################


resource "aws_eip" "nat_eip" {
  vpc        = true
  tags = {
    Name        = "${var.environment}-nat-gateway-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name        = "${var.environment}-nat-gateway"
    Environment = "${var.environment}"
  }
}

#################################################################
# Create Private route table and associate private subnet
#################################################################

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
  cidr_block             = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
   tags = {
    Name        = "${var.environment}-public-route-table"
  }
}


resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id          = aws_subnet.private_subnet_1.id
  route_table_id     = aws_route_table.private_rt.id 
  }

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id          = aws_subnet.private_subnet_2.id
  route_table_id     = aws_route_table.private_rt.id
  }
  
#######################################
#Create Default Security Group
######################################

resource "aws_security_group" "security_group" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Environment = "${var.environment}"
  }
}
