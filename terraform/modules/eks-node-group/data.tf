data "aws_subnet" "private01" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-private-us-east-1c"]
  }
}

data "aws_subnet" "private02" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-private-us-east-1b"]
  }
}

data "aws_subnet" "private03" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-private-us-east-1a"]
  }
}