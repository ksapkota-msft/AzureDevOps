terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "krish-rg" {
  name     = var.resource-group-name
  location = var.location

  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_network" "krish-vm" {
  name                = var.azurerm_virtual_network_name
  location            = azurerm_resource_group.krish-rg.location
  resource_group_name = azurerm_resource_group.krish-rg.name

  address_space = ["10.123.0.0/16"]

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "krish-subnet" {
  name                 = var.azurerm_virtual_network_subnet_name
  resource_group_name  = azurerm_resource_group.krish-rg.name
  virtual_network_name = azurerm_virtual_network.krish-vm.name

  address_prefixes = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "krish-sg" {
  name                = var.azurerm_network_security_group_name
  location            = azurerm_resource_group.krish-rg.location
  resource_group_name = azurerm_resource_group.krish-rg.name

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "network-dev-rule" {
  name                        = var.azurerm_network_security_rule_name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.krish-rg.name
  network_security_group_name = azurerm_network_security_group.krish-sg.name
}

resource "azurerm_subnet_network_security_group_association" "krish-network-dev-sga" {
  subnet_id                 = azurerm_subnet.krish-subnet.id
  network_security_group_id = azurerm_network_security_group.krish-sg.id
}


resource "azurerm_public_ip" "krish-dev-ip" {
  name                = var.azurerm_public_ip_name
  resource_group_name = azurerm_resource_group.krish-rg.name
  location            = azurerm_resource_group.krish-rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "krihs-nic" {
  name                = var.azurerm_network_interface_name
  location            = azurerm_resource_group.krish-rg.location
  resource_group_name = azurerm_resource_group.krish-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.krish-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.krish-dev-ip.id
  }

  tags = {
    environment = var.environment
  }

}

resource "azurerm_linux_virtual_machine" "krish-linux-vm" {
  name                = var.azurerm_linux_virtual_machine_name
  resource_group_name = azurerm_resource_group.krish-rg.name
  location            = azurerm_resource_group.krish-rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.krihs-nic.id,
  ]

  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/krish-devops-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}