resource "aws_vpc" "main" {
  cidr_block  = var.vpc_cidr
  tags        = {
    Name = "main"
  }
}

resource "aws_subnet" "elb" {
  for_each                = { for idx, az_name in local.az_names: az_name => idx }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value)
  availability_zone       = local.az_names[each.value]
  map_public_ip_on_launch = true
  tags                    = {
    Name = "elb-${each.key}"
  }
}

resource "aws_subnet" "app" {
  for_each                = { for idx, az_name in local.az_names: az_name => idx }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value + 4)
  availability_zone       = local.az_names[each.value]
  map_public_ip_on_launch = false
  tags                    = {
    Name = "app-${each.key}"
  }
}

resource "aws_subnet" "db" {
  for_each                = { for idx, az_name in local.az_names: az_name => idx }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value + 8)
  availability_zone       = local.az_names[each.value]
  map_public_ip_on_launch = false
  tags                    = {
    Name = "db-${each.key}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id  = aws_vpc.main.id
}

resource "aws_nat_gateway" "nat" {
  for_each      = { for idx, s in aws_subnet.app : idx => s.id }
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value
}

# output "output" {
#   for_each = { for idx, s in aws_subnet.app[*] : idx => s }
#   value = each.value
# }

resource "aws_eip" "nat" {
  for_each  = { for idx, s in aws_subnet.app : idx => s.id }
  vpc       = true
  tags      = {
    Name = each.value
  }
}

resource "aws_route_table" "elb" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "elb" {
  for_each        = { for idx, s in aws_subnet.elb : idx => s.id }
  subnet_id       = each.value
  route_table_id  = aws_route_table.elb.id
}

resource "aws_route_table" "app" {
  for_each  = { for idx, s in aws_subnet.app : idx => s.id }
  vpc_id    = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[each.key].id
  }
}

resource "aws_route_table_association" "app" {
  for_each        = { for idx, s in aws_subnet.app : idx => s.id }
  subnet_id       = each.value
  route_table_id  = aws_route_table.app[each.key].id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "db" {
  for_each        = { for idx, s in aws_subnet.db : idx => s.id }
  subnet_id       = each.value
  route_table_id  = aws_route_table.db.id
}

resource "aws_security_group" "packer" {
  name    = "packer"
  vpc_id  = aws_vpc.main.id
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "packer"
  }
}
