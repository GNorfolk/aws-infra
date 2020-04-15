module "r53" {
  source = "../../modules/r53"
}

module "secretsmanager" {
  source = "../../modules/secretsmanager"
}
