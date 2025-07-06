# Create a VM linux with docker and nginx installed as custom data

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

5. To format properly the file use: `terraform fmt`

6. To validate sintaxe use: `terraform validate`

7. plan the changes using `terraform plan`. Check the output, if everything is correct deploy it.

8. Deploy using `terraform apply` or `terraform apply -auto-approve`

9. To generate documentation, check [terraform-docs](https://github.com/terraform-docs/terraform-docs) on github. Install the binary and run the follow command on path:
``` pwsh
terraform-docs markdown table --output-file DOCS.md --output-mode inject .
```

10. At the output terminal will show the IP to connect by ssh with the linux VM:
```
VM = [
  "VM: linux-vm-02 : 52.226.77.136",
  "User:fernando",
]
```

11. Connect using: `ssh -i ~\.ssh\fernando_vm fernando@52.226.77.136`

12. After connect, check if script run properly:
```
sudo cat /var/log/cloud-init-output.log
```
