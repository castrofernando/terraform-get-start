#define the azure provider and subscription to be used
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg-02" {
  name     = "02-net-rg"
  location = "eastus"
  tags = {
    "environment" = "dev"
  }
}

#define virtual network 
resource "azurerm_virtual_network" "vn-02" {
  name                = "02-vn"
  location            = azurerm_resource_group.rg-02.location
  resource_group_name = azurerm_resource_group.rg-02.name
  address_space       = ["10.200.0.0/16"]
  tags = {
    "environment" = "dev"
  }
}

# create 2 subnets associated to the previous virtual network
resource "azurerm_subnet" "sb-02-1" {
  name                 = "Subnet-1"
  resource_group_name  = azurerm_resource_group.rg-02.name
  virtual_network_name = azurerm_virtual_network.vn-02.name
  address_prefixes     = ["10.200.1.0/24"]
}

resource "azurerm_subnet" "sb-02-2" {
  name                 = "Subnet-2"
  resource_group_name  = azurerm_resource_group.rg-02.name
  virtual_network_name = azurerm_virtual_network.vn-02.name
  address_prefixes     = ["10.200.2.0/24"]
}

#create the security group
resource "azurerm_network_security_group" "nsg-02" {
  name                = "nsg-dev-02"
  location            = azurerm_resource_group.rg-02.location
  resource_group_name = azurerm_resource_group.rg-02.name

  tags = {
    environment = "dev"
  }
}
#create rules for security group
resource "azurerm_network_security_rule" "vm_nsg_rules-02" {
  for_each = { for index, port in keys(var.inbound_vm_ports) : index => { port = port, name = var.inbound_vm_ports[port] } }

  name                        = each.value.name
  priority                    = (each.key * 10) + 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-02.name
  network_security_group_name = azurerm_network_security_group.nsg-02.name
}

#associate to subnets
resource "azurerm_subnet_network_security_group_association" "nsg-asc-02-1" {
  subnet_id                 = azurerm_subnet.sb-02-1.id
  network_security_group_id = azurerm_network_security_group.nsg-02.id
}

#associate to subnets
resource "azurerm_subnet_network_security_group_association" "nsg-asc-02-2" {
  subnet_id                 = azurerm_subnet.sb-02-2.id
  network_security_group_id = azurerm_network_security_group.nsg-02.id
}

#create public ip
resource "azurerm_public_ip" "public-ip-02" {
  name                = "public_ip-02"
  resource_group_name = azurerm_resource_group.rg-02.name
  location            = azurerm_resource_group.rg-02.location
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}

#create network interface
resource "azurerm_network_interface" "ni-02" {
  name                = "ni-02"
  location            = azurerm_resource_group.rg-02.location
  resource_group_name = azurerm_resource_group.rg-02.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.sb-02-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip-02.id
  }
}

#create a linux virtual machine
resource "azurerm_linux_virtual_machine" "vm-02" {
  name                = "linux-vm-02"
  resource_group_name = azurerm_resource_group.rg-02.name
  location            = azurerm_resource_group.rg-02.location
  size                = "Standard_B2s"
  admin_username      = "fernando"
  network_interface_ids = [
    azurerm_network_interface.ni-02.id
  ]

  #use follow command to generate the ssh key -> ssh-keygen -b 2048 -t rsa -C "<user>"
  admin_ssh_key {
    username   = "fernando"
    public_key = file("~/.ssh/fernando_vm.pub")
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
  #script to run on VM creation
  custom_data = filebase64("installDocker.tpl")
}