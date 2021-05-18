# General purpose parameters
variable "client_secret" {
  type        = string
  description = "The password for this user"
}

variable "subscription_id" {
  type        = string
  description = "The subscription to which the configurations must be applied"
}

variable "client_id" {
  type        = string
  description = "The user name"
}

variable "tenant_id" {
  type        = string
  description = "The identification for Microsoft AD"
}

variable "environment" {
  type        = string
  description = "Target Environment"
  default     = "dev"
}

variable "location" {
  description = "Target Location"
  default     = "East US 2"
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "sampleDEV"
}

variable "timestamp" {
  type        = number
  description = "Creation Timestamp for this run"
}

# Variables for tags
variable "billing_code_tag" {
  type        = string
  default     = "Sample"
  description = "The billing code to add as tag"
}

variable "acr_reader_user_client_id" {}
variable "acr_reader_user_secret_key" {}

# Variables for remote storage of the state file
variable "arch_resource_group_name" {
  type        = string
  description = "Resource group name for arch artifacts"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name for storing the tfstate file"
}

variable "storage_container_name" {
  type        = string
  description = "Storage account name for storing the tfstate file"
  default     = "terraform-tfstate-files"
}

variable "remote_tfstate_file_name" {
  type        = map(string)
  description = "File name for the tfstate"
  default = {
    dev = "dev-tfstate.tfstate"
    qa  = "qa-tfstate.tfstate"
    hlg = "hlg-tfstate.tfstate"
    prd = "prd-tfstate.tfstate"
  }
}