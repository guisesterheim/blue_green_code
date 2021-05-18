variable "resource_group_name" {}
variable "location" {}
variable "environment" {}
variable "billing_code_tag" {}
variable "billing_code_tag" {}
variable "timestamp" {}

locals {
  common_tags = {
    BillingCode = var.billing_code_tag
    Environment = var.environment
  }

  resource_group_name = "${var.resource_group_name}-${var.environment}-${var.timestamp}"
}