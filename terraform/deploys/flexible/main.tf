module "vpc" {
  source = "../../modules/vpc_full"
  cidr = "10.0.0.0/16"
}
