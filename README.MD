# Commands Terraform

## IMPORTANT:

For all tutorials, follow the steps below:
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

----------------------------------


## Main
`terraform init`: Initialize terraform and download providers at the root folder

`terraform fmt`: Format terraform file

`terraform validate`: Validate sintaxe on terraform files at folder

`terraform plan`: Show the plan to apply the infrastructure.

`terraform apply`: Create the resources <i>(`-auto-approve` to not need confirmation)</i>

`terraform destroy`: Remove all resources created that are tracked on state

## Others
`terraform workspace`: Create / list/ switch between workspaces
    
    - new <workspace>
    - list
    - select <workspace>

`terraform state`: Show information about state

    - list
    - show <resource>

`terraform show`: show all information about states