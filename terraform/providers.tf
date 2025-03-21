terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.67.0"
    }
  }
}

terraform {
  backend "s3" {
    key = "terraform.tfstate"
  }
}