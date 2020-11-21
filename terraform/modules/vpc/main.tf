resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "elb" {
  for_each                = { for idx, az_name in local.az_names: az_name => idx }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value)
  availability_zone       = local.az_names[each.value]
  map_public_ip_on_launch = true
  Tags = {
    Name = "elb-${each.value}"
  }
}

resource "aws_subnet" "app" {
  for_each                = { for idx, az_name in local.az_names: az_name => idx }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.value + 4)
  availability_zone       = local.az_names[each.value]
  map_public_ip_on_launch = false
  Tags = {
    Name = "app-${each.value}"
  }
}

# resource "aws_subnet" "app" {
#   for_each = var.mapping
#   vpc_id = aws_vpc.main.id
#   cidr_block = cidrsubnet(var.cidr, 4, each.value + 3)
#   map_public_ip_on_launch = var.dev ? true : false
#   availability_zone = join("", ["eu-west-1", each.key])
#   tags = {
#     Name = join("", ["app_az_", each.key])
#   }
# }

# resource "aws_subnet" "db" {
#   for_each = var.mapping
#   vpc_id = aws_vpc.main.id
#   cidr_block = cidrsubnet(var.cidr, 4, each.value + 6)
#   map_public_ip_on_launch = false
#   availability_zone = join("", ["eu-west-1", each.key])
#   tags = {
#     Name = join("", ["db_az_", each.key])
#   }
# }

# resource "aws_internet_gateway" "main" {
#   vpc_id = aws_vpc.main.id
# }

# resource "aws_eip" "nat" {
#   count = var.dev ? 0 : 1
#   vpc = true
# }

# resource "random_shuffle" "az" {
#   result_count = 1
#   input = [
#     for az, _ in var.mapping:
#       az
#   ]
# }

# resource "aws_nat_gateway" "nat" {
#   count = var.dev ? 0 : 1
#   allocation_id = aws_eip.nat[0].id
#   subnet_id = aws_subnet.elb[random_shuffle.az.result[0]].id
# }

# resource "aws_route_table" "elb" {
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main.id
#   }
# }

# resource "aws_route_table_association" "elb" {
#   for_each = var.mapping
#   subnet_id      = aws_subnet.elb[each.key].id
#   route_table_id = aws_route_table.elb.id
# }

# resource "aws_route_table" "app" {
#   for_each = var.mapping
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = var.dev ? aws_internet_gateway.main.id : aws_nat_gateway.nat[0].id
#   }
# }

# resource "aws_route_table_association" "app" {
#   for_each = var.mapping
#   subnet_id      = aws_subnet.app[each.key].id
#   route_table_id = aws_route_table.app[each.key].id
# }

# resource "aws_route_table" "db" {
#   vpc_id = aws_vpc.main.id
# }

# resource "aws_route_table_association" "db" {
#   for_each = var.mapping
#   subnet_id      = aws_subnet.db[each.key].id
#   route_table_id = aws_route_table.db.id
# }

# resource "aws_security_group" "packer" {
#   name          = "packer"
#   vpc_id        = aws_vpc.main.id
#   ingress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "packer"
#   }
# }
