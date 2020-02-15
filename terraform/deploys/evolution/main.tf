module "vpc" {
  source = "../../modules/vpc-dev"
  cidr = "10.0.0.0/16"
  mapping = {a = 0, b = 1}
  dev = var.dev
}
