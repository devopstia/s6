resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.vpc.id

  // Define ingress rule to allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  // Define egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Add a tag
  tags = {
    Name    = "instance_sg"
    env     = "dev"
    project = "s6"
  }
}