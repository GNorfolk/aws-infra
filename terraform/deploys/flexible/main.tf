module "vpc" {
  source = "../../modules/vpc_full"
  cidr = 10.0.0.0/16
  mapping = {a = 0, b = 1, c = 2}
}
