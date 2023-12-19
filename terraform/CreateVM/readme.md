## Guide: Creating a new dev environment 

- Create a new Azure VM with Linux image pre-installed
- Install docker image in the VM 

To run this command, following files must exists in the folder

* Pre-requisites
- install Terraform, Az Cli
- Login to Azure by running below commands
- az login --use-device-code

Folder contains below files
* `main.tf` - which contains the code for the example
* `variables.tf` - which contains all of the variables used in this example
* `customdata.tpl` - which contains the script to install docker in the VM 
* `dev.tfvars` - This contains the variables - environment specific variables, there will be diferent file for other managed environment

Commands Example
- terraform init `for the fist time`
- terraform plan -var-file="dev.tfvars"
- terraform apply -var-file="dev.tfvars" --auto-approve

To Verify the VM
- find the public IP of the VM by running below commands
    - terraform state list 
    - terraform state show 'select the name of the VM from the state list' and find the dynamic public IP

SSH to the VM
- ssh -i ~/.ssh/<ssh-key-name> adminuser@<IP address of VM>

