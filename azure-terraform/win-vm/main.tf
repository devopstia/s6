
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "example-ipconfig"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-vm"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.example.id
  ]

  vm_size                       = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "example-vm"
    admin_username = "adminuser"
    admin_password = "AdminPassword1234!"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
