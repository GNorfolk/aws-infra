module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  mapping = var.dev ? { a = 0, b = 1 } : { a = 0, b = 1, c = 2 }
  dev = var.dev
}
