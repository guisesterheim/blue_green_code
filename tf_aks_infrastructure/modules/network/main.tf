# Security group for the app
# It allows connections just from the security group above
resource "azurerm_network_security_group" "app_sg" {
  name                = "app_sg-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_from_internet_app"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = var.common_tags
}

# VPC - Our own network
resource "azurerm_virtual_network" "VPC" {
  name                = "sampleVPC-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = lookup(var.vpc_default_ip_address, var.environment)

  tags = var.common_tags
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "subnet_app"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.VPC.name
  address_prefixes     = lookup(var.app_subnet_ip_range, var.environment)
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_sg_association" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_sg.id
}