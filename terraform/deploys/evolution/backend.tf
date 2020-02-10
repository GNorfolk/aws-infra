terraform {
  backend "s3" {
    bucket = "norfolkgaming-tfstate"
    key = "aws-flexible.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}
