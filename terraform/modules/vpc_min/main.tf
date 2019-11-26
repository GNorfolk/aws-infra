resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

resource "aws_subnet" "elb_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 0)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "app_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 3)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "db_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 6)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
}

resource "aws_eip" "nat_az_a" {
  vpc = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "az_a" {
  allocation_id = aws_eip.nat_az_a.id
  subnet_id = aws_subnet.elb_az_a.id
}

resource "aws_route_table" "elb" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "elb_az_a" {
  subnet_id      = aws_subnet.elb_az_a.id
  route_table_id = aws_route_table.elb.id
}

resource "aws_route_table" "app_az_a" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.az_a.id
  }
}

resource "aws_route_table_association" "app_az_a" {
  subnet_id      = aws_subnet.app_az_a.id
  route_table_id = aws_route_table.app_az_a.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "db_az_a" {
  subnet_id      = aws_subnet.db_az_a.id
  route_table_id = aws_route_table.db.id
}
