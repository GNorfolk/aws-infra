terraform {
  backend "s3" {
    bucket = "norfolkgaming-tfstate"
    key = "aws-static.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}
