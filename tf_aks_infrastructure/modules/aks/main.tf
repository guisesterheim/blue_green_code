# Creates the AKS
resource "azurerm_kubernetes_cluster" "AKS" {
  name                = "aks-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.environment}"

  default_node_pool {
    name                = "main"
    vm_size             = "Standard_D2_v4"
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"
    max_count           = lookup(var.auto_scaling_max_count, var.environment)
    min_count           = lookup(var.auto_scaling_min_count, var.environment)
    node_count          = lookup(var.auto_scaling_default_node_count, var.environment)
    node_labels         = { app : "main" }
    vnet_subnet_id      = var.app_subnet_id

    tags = var.common_tags
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled = false
    }
  }

  network_profile {
    network_plugin = "azure"
  }

  node_resource_group = "${var.resource_group_name}-nodes"

  service_principal {
    client_id     = var.acr_reader_user_client_id
    client_secret = var.acr_reader_user_secret_key
  }

  timeouts {
    create = "15m"
  }

  tags = var.common_tags
}