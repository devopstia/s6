resource "aws_iam_role" "nodes_general" {
  name               = format("%s-%s-node-group-role", var.tags["environment"], var.tags["project"])
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes_general.name
}

resource "aws_eks_node_group" "nodes_general" {

  cluster_name    = format("%s-%s-eks", var.tags["environment"], var.tags["project"])
  node_group_name = format("%s-%s-node-group", var.tags["environment"], var.tags["project"])
  node_role_arn   = aws_iam_role.nodes_general.arn
  subnet_ids = [
    data.aws_subnet.private01.id,
    data.aws_subnet.private02.id,
    data.aws_subnet.private03.id
  ]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  labels = {
    role = var.node_label
  }
  version = var.eks_version
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}
