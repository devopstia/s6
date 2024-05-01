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


data "aws_subnet" "private-subnet" {
  filter {
    name   = "tag:Name"
    values = ["dev-s6-vpc-private-us-east-1c"]
  }
}
