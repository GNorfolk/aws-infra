resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_aza" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 0)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "public_azb" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 1)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "public_azc" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 2)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
}

resource "aws_subnet" "app_aza" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 3)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "app_azb" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 4)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "app_azc" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 5)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"
}

resource "aws_subnet" "db_aza" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 6)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "db_azb" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 7)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"
}

resource "aws_subnet" "db_azc" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet("10.0.0.0/16", 4, 8)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"
}
