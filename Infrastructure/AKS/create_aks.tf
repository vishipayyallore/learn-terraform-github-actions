data "azurerm_resource_group" "k8s" {
  name = "rg-dnlh-12mar-test"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = data.azurerm_resource_group.k8s.location
  resource_group_name = data.azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix

  # linux_profile {
  #   admin_username = "ubuntu"
  #   admin_password = "Passw0rd1234!"

  #   ssh_key {
  #     key_data = file(var.ssh_public_key)
  #   }
  # }

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  # addon_profile {
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
  # }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "Development"
  }
}