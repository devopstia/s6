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
    key            = "eks-node-group/terraform.tfstate" # state file name
    region         = "us-east-1"
    dynamodb_table = "s6-terraform-s3-lock" # optional, enables state locking with DynamoDB
  }
}

locals {
  aws_region           = "us-east-1"
  desired_size         = "1"
  max_size             = "1"
  min_size             = "1"
  eks_version          = "1.28"
  capacity_type        = "ON_DEMAND"
  disk_size            = "20"
  force_update_version = false
  instance_types       = ["t3.small"]
  node_label           = "general"
  ami_type             = "AL2_x86_64"
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

module "eks-node-group" {
  source               = "../../../modules/eks-node-group"
  aws_region           = local.aws_region
  eks_version          = local.eks_version
  desired_size         = local.desired_size
  max_size             = local.max_size
  min_size             = local.min_size
  capacity_type        = local.capacity_type
  disk_size            = local.disk_size
  force_update_version = local.force_update_version
  instance_types       = local.instance_types
  node_label           = local.node_label
  ami_type             = local.ami_type
  tags                 = local.tags
}
