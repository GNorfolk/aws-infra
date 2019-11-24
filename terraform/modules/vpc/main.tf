resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "elb_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 0)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "elb_az_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 1)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "elb_az_c" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 2)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
}

resource "aws_subnet" "app_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 3)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "app_az_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 4)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "app_az_c" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 5)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"
}

resource "aws_subnet" "db_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 6)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "db_az_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 7)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "db_az_c" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 8)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat_az_a" {
  vpc = true
}

resource "aws_eip" "nat_az_b" {
  vpc = true
}

resource "aws_eip" "nat_az_c" {
  vpc = true
}

resource "aws_nat_gateway" "az_a" {
  allocation_id = aws_eip.nat_az_a.id
  subnet_id = aws_subnet.elb_az_a.id
}

resource "aws_nat_gateway" "az_b" {
  allocation_id = aws_eip.nat_az_b.id
  subnet_id = aws_subnet.elb_az_b.id
}

resource "aws_nat_gateway" "az_c" {
  allocation_id = aws_eip.nat_az_c.id
  subnet_id = aws_subnet.elb_az_c.id
}
