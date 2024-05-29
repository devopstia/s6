
variable "aws_region" {
  type = string
}

variable "desired_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "min_size" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "capacity_type" {
  type = string
}

variable "force_update_version" {
  type = bool
}

variable "instance_types" {
  type = list(string)
}

variable "node_label" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "ami_type" {
  type = string
}


