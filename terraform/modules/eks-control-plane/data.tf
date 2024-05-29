data "aws_subnet" "public01" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-public-us-east-1c"]
  }
}

data "aws_subnet" "public02" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-public-us-east-1b"]
  }
}

data "aws_subnet" "public03" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-public-us-east-1a"]
  }
}