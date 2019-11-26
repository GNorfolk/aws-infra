resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

resource "aws_subnet" "elb_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 0)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
    Name = "elb_az_a"
  }
}

resource "aws_subnet" "elb_az_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 1)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
  tags = {
    Name = "elb_az_b"
  }
}

resource "aws_subnet" "elb_az_c" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 2)
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
  tags = {
    Name = "elb_az_c"
  }
}

resource "aws_subnet" "app_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 3)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
  tags = {
    Name = "app_az_a"
  }
}

resource "aws_subnet" "app_az_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 4)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"
  tags = {
    Name = "app_az_b"
  }
}

resource "aws_subnet" "app_az_c" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 5)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"
  tags = {
    Name = "app_az_c"
  }
}

resource "aws_subnet" "db_az_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 6)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
  tags = {
    Name = "db_az_a"
  }
}

resource "aws_subnet" "db_az_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 7)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1b"
  tags = {
    Name = "db_az_b"
  }
}

resource "aws_subnet" "db_az_c" {
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr, 4, 8)
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1c"
  tags = {
    Name = "db_az_c"
  }
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

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
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

resource "aws_route_table_association" "elb_az_b" {
  subnet_id      = aws_subnet.elb_az_b.id
  route_table_id = aws_route_table.elb.id
}

resource "aws_route_table_association" "elb_az_c" {
  subnet_id      = aws_subnet.elb_az_c.id
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

resource "aws_route_table" "app_az_b" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.az_b.id
  }
}

resource "aws_route_table_association" "app_az_b" {
  subnet_id      = aws_subnet.app_az_b.id
  route_table_id = aws_route_table.app_az_b.id
}

resource "aws_route_table" "app_az_c" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.az_c.id
  }
}

resource "aws_route_table_association" "app_az_c" {
  subnet_id      = aws_subnet.app_az_c.id
  route_table_id = aws_route_table.app_az_c.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "db_az_a" {
  subnet_id      = aws_subnet.db_az_a.id
  route_table_id = aws_route_table.db.id
}

resource "aws_route_table_association" "db_az_b" {
  subnet_id      = aws_subnet.db_az_b.id
  route_table_id = aws_route_table.db.id
}

resource "aws_route_table_association" "db_az_c" {
  subnet_id      = aws_subnet.db_az_c.id
  route_table_id = aws_route_table.db.id
}
