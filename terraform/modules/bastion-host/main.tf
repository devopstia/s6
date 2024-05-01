resource "aws_instance" "example" {
  # depends_on = [
  #   aws_security_group.instance_sg
  # ]
  ami           = "ami-080e1f13689e07408" # Update with your desired AMI ID
  instance_type = "t2.micro"              # Update with your desired instance type
  key_name      = "jenkins-key"           # Update with your key pair name
  subnet_id     = data.aws_subnet.public-subnet.id

  // Assigning the security group to the instance
  vpc_security_group_ids = [data.aws_security_group.instance_sg_data.id]

  tags = {
    Name = "bastion-host" # Update with your desired instance name
  }
  # Adding storage
  root_block_device {
    volume_size = 20    # Size of the root volume in gigabytes
    volume_type = "gp2" # Type of volume (e.g., gp2, standard, io1)
  }
}

# resource "aws_eip_association" "example" {
#   instance_id   = aws_instance.example.id
#   allocation_id = data.aws_eip.existing_eip.id
# }