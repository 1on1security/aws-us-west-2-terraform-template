# Create the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

################################# PUBLIC ##############################
# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zone1
  cidr_block        = var.public_subnet
  tags = {
    Name = var.public_subnet_name
  }
}

# Route table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public.id
  }
  tags = {
    Name = var.public_route_name
  }
}

# Route table Association with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  tags = {
    Name = var.eip_name
  }
}
# Create Public Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}
################################# PRIVATE ##############################

# Create Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zone1
  cidr_block        = var.private_subnet
  tags = {
    Name = var.private_subnet_name
  }
}

# Route table for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = var.private_route_name
  }
}

# Route table Association with Private Subnet
resource "aws_route_table_association" "private" {

  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Create the NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = var.nat_gateway_name
  }
}

# Create an S3 VPC Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-west-2.s3"
  route_table_ids = [
    aws_route_table.public.id,
    aws_route_table.private.id,
  ]

  tags = {
    Name = "s3-endpoint"
  }
}