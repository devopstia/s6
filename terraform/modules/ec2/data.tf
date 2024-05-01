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


data "aws_eip" "existing_eip" {
  filter {
    name   = "tag:Name"
    values = ["eip"] # Replace with the value of the tag you want to filter by
  }
}

output "eip_address" {
  value = data.aws_eip.existing_eip.public_ip
}