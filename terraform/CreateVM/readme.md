## Guide: Creating a new dev environment 

- Create a new Azure VM with Linux image pre-installed
- Install docker image in the VM 

To run this command, the following files must exist in the folder:

* Pre-requisites
    - Install Terraform, Az Cli
    - Login to Azure by running the command: `az login --use-device-code`

Folder contains the following files:
* `main.tf` - contains the code for the example
* `variables.tf` - contains all of the variables used in this example
* `customdata.tpl` - contains the script to install docker in the VM 
* `dev.tfvars` - contains the environment-specific variables (there will be a different file for other managed environments)

Commands Example:
- `terraform init` (for the first time)
- `terraform plan -var-file="dev.tfvars"`
- `terraform apply -var-file="dev.tfvars" --auto-approve`

To Verify the VM:
- Find the public IP of the VM by running the following commands:
    - `terraform state list`
    - `terraform state show 'select the name of the VM from the state list'` and find the dynamic public IP

SSH to the VM:
- `ssh -i ~/.ssh/<ssh-key-name> adminuser@<IP address of VM>`