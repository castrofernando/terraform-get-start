output "VM" {
  value = ["VM: ${azurerm_linux_virtual_machine.vm-02.name} : ${azurerm_public_ip.public-ip-02.ip_address}",
  "User:${azurerm_linux_virtual_machine.vm-02.admin_username}"]
}