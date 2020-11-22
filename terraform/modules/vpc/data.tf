data "aws_availability_zones" "azs" {
  state = "available"
  filter {
    name   = "zone-name"
    values = ["eu-west-1a"]
  }
}