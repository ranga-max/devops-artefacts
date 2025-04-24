
locals {
   inbound_ports = [ 80, 443 ]
   outbound_ports = [ 80, 443 ]
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

# Subnets
# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.ig]
}

# NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name        = "nat"
    Environment = "${var.environment}"
  }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index % length(var.availability_zones))
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index % length(var.availability_zones))}-public-subnet"
    Environment = "${var.environment}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index % length(var.availability_zones))
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index % length(var.availability_zones))}-private-subnet"
    Environment = "${var.environment}"
  }
}


# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# Route for NAT
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "sg-webserver" {
  name        = "webserver"
  description = "Security Group for Web Servers"
  vpc_id      = aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = local.inbound_ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# Default Security Group of VPC
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default SG to allow traffic from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

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

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    security_groups = ["${aws_security_group.sg-webserver.id}"]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    security_groups = ["${aws_security_group.sg-webserver.id}"]
  }

  tags = {
    Environment = "${var.environment}"
  }
}

#Rule anything needed from aws to cc should only be sourced from aws modules
# Create a local variable that maps Zoneid and Subnet id to pass it to CC private link module
locals {
  subnets_to_privatelink = { for item in aws_subnet.private_subnet : item.availability_zone_id => item.id 
     #aws_subnet.private_subnet[idx].availability_zone_id  = aws_subnet.private_subnet[idx].id 
  }
} 



