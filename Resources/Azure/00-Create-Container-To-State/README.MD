# Create a Storage Container to save TFState

All tutorial was based on microsoft guide published [here](https://learn.microsoft.com/pt-br/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)

## Steps
1. Login at azure
``` pwsh
az login
```

2. Set your  account using
``` pwsh
az account set --subscription "<subscription_id>"
```

3. Set locally an environment variable as follow using power shell:
All environment variables used by terraform must have the prefix `TF_VAR_`
``` pwsh
$env:TF_VAR_SUBSCRIPTION_ID="<subscription_id>"
```
Note-> you can also pass this variable in command using: 

- `-var "SUBSCRIPTION_ID=<subscription_id>"`

- `tfvars` file with arg: `-var_file="myFile.tfvars"`

1. Create a storage account. Here we will use `00-create-remote-storage.tf` to do it.

```
terraform init
terraform apply --auto-aprove
```

# Output
It will generate the follow values as output like this below. Use this storage in others scripts to set/get the remote state:
```
  containerInfo = {
    ResourceGroup         = "tfstate"
    StorageAccountName    = "tfstatesw1j5"
    StorageContainer      = "tfstate"
  }
```

To get the Storage account key, use:
```
az storage account keys list --resource-group <ResourceGroup> --account-name <StorageAccountName>
```