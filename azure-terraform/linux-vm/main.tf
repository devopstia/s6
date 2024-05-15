# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

# # Define a public IP address
# resource "azurerm_public_ip" "public_ip" {
#   name                = "vm-public-ip"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   tags                = var.tags
# }

# Define a network interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "example-ipconfig"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  tags = var.tags
}

# Associate a network security group with the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

# Define a Linux virtual machine
resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  computer_name       = "example-vm"
  admin_username      = "adminuser"
  admin_password      = "AdminPassword1234!" # Or use SSH key instead

  size = "Standard_DS1_v2" # Adjust based on your requirements

  network_interface_ids = [
    azurerm_network_interface.example.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "30"
    name                 = "linux-vm-disk"
  }

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("./ssh-key/azure-terraform.pub") # Path to your SSH public key
  }

  disable_password_authentication = false # For enhanced security
}
