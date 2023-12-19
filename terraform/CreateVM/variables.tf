variable "environment" {
  description = "The envornment for creating azure resources"
  default     = "dev"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "West US"
}

variable "resource-group-name" {
  description = "The name of the resource group used in this example for creating azure resources"
  default     = "dev-resources"
}

variable "azurerm_virtual_network_name" {
  description = "The name of the azure virtual network."
  default     = "dev-network"
}

variable "azurerm_virtual_network_subnet_name" {
  description = "The name of the azure virtual network."
  default     = "dev_subnet"
}

variable "azurerm_network_security_group_name" {
  description = "The name of the azure network Security Group."
  default     = "dev-network-sg"
}

variable "azurerm_network_security_rule_name" {
  description = "The name of the azure network Security Group."
  default     = "dev-network-rule"
}

variable "azurerm_public_ip_name" {
  description = "The public IP name."
  default     = "dev-public-ip"
}

variable "azurerm_network_interface_name" {
  description = "The network interface name."
  default     = "dev-nic"
}

variable "azurerm_linux_virtual_machine_name" {
  description = "The vm name."
  default     = "dev-linux-vm"
}

variable "admin_ssh_key_path" {
  description = "The ssh key to access VM."
  default     = "~/.ssh/ssh-key.pub"
}



















