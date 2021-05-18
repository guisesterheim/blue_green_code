variable "location" {}
variable "resource_group_name" {}
variable "environment" {}
variable "common_tags" {}
variable "common_tags" {}

# Network parameters
variable "allow_inbound_traffic" {
  type = map(list(string))
  default = {
    dev = ["80", "443", "8080", "22", "5432"]
    qa  = ["80", "443", "8080", "22", "5432"]
    prd = ["80", "443"]
  }
}

# Security parameters
variable "ddos_protection" {
  type = map(number)
  default = {
    dev = 0
    qa  = 0
    prd = 1
  }
}

variable "vpc_default_ip_address" {
  type        = map(list(string))
  description = "IP addresses for VPC"
  default = {
    dev = ["10.3.0.0/16"]
    qa  = ["10.2.0.0/16"]
    hlg = ["10.1.0.0/16"]
    prd = ["10.0.0.0/16"]
  }
}

variable "app_subnet_ip_range" {
  type        = map(list(string))
  description = "IP range for the app subnet"
  default = {
    dev = ["10.3.2.0/24"]
    qa  = ["10.2.2.0/24"]
    hlg = ["10.1.2.0/24"]
    prd = ["10.0.2.0/24"]
  }
}