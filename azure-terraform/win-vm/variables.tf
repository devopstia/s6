variable "location" {
  type    = string
  default = "East US"
}

variable "tags" {
  type = map(any)
}

variable "subscription_id" {
  type = string
}