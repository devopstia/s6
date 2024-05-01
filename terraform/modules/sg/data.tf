data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc"] # Replace with the value of the tag you want to filter by
  }
}


data "aws_security_group" "instance_sg_data" {
  tags = {
    Name = "instance_sg"
  }
}

output "security_group_id" {
  value = data.aws_security_group.instance_sg_data.id
}


data "aws_security_group" "instance_sg_data2" {
  tags = {
    Name = "allow-all-traffic"
  }
}

output "security_group_id2" {
  value = data.aws_security_group.instance_sg_data2.id
}

output "aws_vpc" {
  value = data.aws_vpc.vpc.id
}
