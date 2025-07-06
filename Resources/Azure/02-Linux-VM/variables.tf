variable "subscription_id" {
  type = string
}

variable "inbound_vm_ports" {
  type = map(string)
  default = {
    22   = "SSH"
    3389 = "RDP"
    80   = "HTTP"
    443  = "HTTPS"
  }
}