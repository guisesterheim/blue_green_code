# Declares the main provider
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}

terraform {
  backend "azurerm" {}
}

# Common group
module "common" {
  resource_group_name        = var.resource_group_name
  location                   = var.location
  environment                = var.environment
  billing_code_tag    = var.billing_code_tag
  timestamp                  = var.timestamp

  source = "./modules/common"
}

# Network group
module "network" {
  location    = var.location
  environment = var.environment

  # Otuput module common
  resource_group_name   = module.common.resource_group_name
  common_tags    = module.common.common_tags

  source     = "./modules/network"
  depends_on = [module.common]
}

# AKS group
module "aks" {
  location    = var.location
  environment = var.environment

  # Output module common
  resource_group_name   = module.common.resource_group_name
  common_tags    = module.common.common_tags

  # Output module network
  app_subnet_id = module.network.app_subnet_id

  acr_reader_user_client_id  = var.acr_reader_user_client_id
  acr_reader_user_secret_key = var.acr_reader_user_secret_key

  source     = "./modules/aks"
  depends_on = [module.common, module.network]
}