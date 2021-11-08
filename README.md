# Introduction 
Demo for terraform on Azure

# Workplace setup using PowerShell 7

## Login
Connect-AzAccount
## Get subscriptions
Get-AzSubscription

## Set subscription
Set-AzContext -Subscription "Visual Studio Professional-abonnement"

## Insufficient privileges to create a service principal, but if you have:
$sp = New-AzADServicePrincipal -DisplayName sp_terraform
New-AzADServicePrincipal: Insufficient privileges to complete the operation.

## Make note of the ApplicationId. You need it later
$sp.ApplicationId

##
# 
Storage account for Terraform
az group create -n dev-terraform-backend-rg -l westeurope

# storage account
az storage account create --resource-group dev-terraform-backend-rg --name devterraformbackendsa --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group dev-terraform-backend-rg --account-name devterraformbackendsa --query [0].value -o tsv)

# Create blob container
az storage container create --name terraform-backend-files --account-name devterraformbackendsa --account-key $ACCOUNT_KEY

From <https://medium.com/microsoftazure/creating-a-single-secure-azure-devops-yaml-pipeline-to-provision-multiple-environments-using-620900aae18> 


## terraform commands used
### one-time only
terraform init -backend-config="terraform-backend.secrets"

terraform validate

### create plan to create/update services
terraform plan -out test-create.plan
### create/update services
terraform apply test-create.plan

### create plan to destroy services
terraform plan -destroy -out test-destroy.plan
### destroy services
terraform apply test-destroy.plan
