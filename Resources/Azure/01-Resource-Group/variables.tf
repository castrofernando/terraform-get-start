variable "region_environment" {
  type = map(string)
  default = {
    "default" = "eastus"
    "dev"     = "eastus"
    "hmg"     = "westus"
    "prod"    = "southcentralus"
  }
  description = "environment map to deploy in properly region"
}

variable "subscription_id" {
  type = string
  description = "Azure subscription id value"
}