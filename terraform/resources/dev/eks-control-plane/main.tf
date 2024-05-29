terraform {
  required_version = ">= 1.0.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Configure Terraform backend to use S3
terraform {
  backend "s3" {
    bucket         = "s6-terraform-s3-backend"
    key            = "eks-control-plane/terraform.tfstate" # state file name
    region         = "us-east-1"
    dynamodb_table = "s6-terraform-s3-lock" # optional, enables state locking with DynamoDB
  }
}

locals {
  aws_region              = "us-east-1"
  eks_version             = "1.28"
  endpoint_private_access = false
  endpoint_public_access  = true

  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "development"
    "project"        = "revive"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "eks-control-plane" {
  source                  = "../../../modules/eks-control-plane"
  aws_region              = local.aws_region
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  tags                    = local.tags
}
