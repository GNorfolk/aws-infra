terraform {
  backend "s3" {
    bucket = "norfolkgaming-tfstate"
    key = "aws-fixed.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}
