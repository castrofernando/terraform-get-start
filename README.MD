# Commands Terraform

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