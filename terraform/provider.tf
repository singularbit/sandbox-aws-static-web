provider "aws" {

  region = var.aws_region
  
  default_tags {
    tags = {
      Owner          = "Singularbit Labs"
      Project        = "Singularbit Labs Static Website"
      DeploymentType = "Terraform"
      Developers     = "Pedro"
    }
  }
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
}
