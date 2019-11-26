module "vpc" {
  source = "../../modules/vpc_min"
  cidr = "10.0.0.0/16"
}
