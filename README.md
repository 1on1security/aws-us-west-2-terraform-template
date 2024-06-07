# aws-us-west-2-terraform-template
## Yet Another Terraform template to create a VPC with:

1. Public and private subnets
2. A public and private EC2 Instance running Ubuntu 22.04
3. Internet and NAT gateway, and S3 endpoint
4. All associated routing tables and associations.

# BEFORE YOU BEGIN!!!
## Be sure to execute the "prepare-ssh-keys.bash" script before running Terraform.
The script generates a fresh SSH keypair, and prepares a bash file called as "user_data" for each server, ensuring the public key is deployed on each server. <b>KEYS/aws.template-key is your PRIVATE key, allowing access to both servers.  Safeguard it accordingly.</b>

### The template was built and tested from within WSL2 (Ubuntu 22.04) on a Windows 11 Pro workstation.

### DEPENDENCIES

### Follow instructions for installing the AWS CLI on your Linux system.
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

`sudo snap install aws-cli --classic` is always an option.

### Follow instructions for installing Terraform on your Ubuntu instance
https://developer.hashicorp.com/terraform/install

`wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg`

`echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list`

`sudo apt update && sudo apt install terraform`

<hr>

## Short, sweet and easy

`git clone` <br>
`cd us-west-2-template` <br>
`./prepare-ssh-keys.bash` <br>
`terraform init` <br>
`terraform plan` <br>
`terraform deploy` <br>