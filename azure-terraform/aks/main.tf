resource "azurerm_kubernetes_cluster" "default" {
  name                = "aks"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "k8s"
  kubernetes_version  = "1.28.9"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "second_node_pool" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  name                  = "secondpool"
  vm_size               = "Standard_DS2_v2"
  # vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
  orchestrator_version = "1.28.9"
  enable_auto_scaling  = true
  max_count            = 3
  min_count            = 1
  os_disk_size_gb      = 30
  mode                 = "User"
  priority             = "Regular"
  os_type              = "Linux"
  node_labels = {
    "nodepool-type" = "second"
    "environment"   = "dev"
    "nodepoolos"    = "linux"
    "app"           = "second-apps"
  }
  tags = var.tags
}