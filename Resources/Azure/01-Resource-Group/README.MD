# Build something

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


4. Initialize terraform with `terraform init` in root folder. It will download the providers needed.

5. Create different workspaces: `dev` , `hmg` , `prod`
``` pwsh
terraform workspace new dev
terraform workspace new hmg
terraform workspace new prod
```

6. Use `terraform workspace list` to check that all were created properly. 
```
  default
  dev
  hmg
* prod
```

7. To format properly the file use: `terraform validate`

8. To validate sintaxe use: `terraform validate`

9. plan the changes using `terraform plan`. Check the output, if everything is correct deploy it.

10. Deploy using `terraform apply` or `terraform apply -auto-approve`

11. To generate documentation, check [terraform-docs](https://github.com/terraform-docs/terraform-docs) on github. Install the binary and run the follow command on path:
``` pwsh
terraform-docs markdown table --output-file DOCS.md --output-mode inject .
```

12. Try it again changing the workspace, using: `terraform workspace select hmg` . <i>

PS: Note that create(<b>apply</b>) and <b>destroy</b> will follow selected workspace. So to delete related infrastructure, it´s needed to switch to the correct workspace where the resource was created.</i>