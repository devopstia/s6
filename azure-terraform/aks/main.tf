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
    vnet_subnet_id  = data.azurerm_subnet.existing_subnet.id
  }

  windows_profile {
    admin_username = "azureuser"
    # admin_password = "P@ssw0rd1234!$#" 
    admin_password = data.azurerm_key_vault_secret.example.value
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    # network_policy can be omitted as it defaults to Azure CNI
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
  vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
  orchestrator_version  = "1.28.9"
  enable_auto_scaling   = true
  max_count             = 3
  min_count             = 1
  os_disk_size_gb       = 30
  mode                  = "User"
  priority              = "Regular"
  os_type               = "Linux"
  node_labels = {
    "nodepool-type" = "second"
    "environment"   = "dev"
    "nodepoolos"    = "linux"
    "app"           = "second-apps"
  }
  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "windows_pool" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  name                  = "wpool"
  mode                  = "User"
  vm_size               = "Standard_DS2_v2"
  os_type               = "Windows"
  vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
  orchestrator_version  = "1.28.9"
  priority              = "Regular"
  enable_auto_scaling   = true
  max_count             = 3
  min_count             = 1
  os_disk_size_gb       = 60 # Update June 2023

  node_labels = {
    "nodepool-type" = "windowspool"
    "environment"   = "dev"
    "nodepoolos"    = "windows"
    "app"           = "dotnet-apps"
  }
  tags = var.tags
}