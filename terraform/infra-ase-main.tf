# Configure the Azure provider
terraform {
  required_version = ">= 0.14.9"
}


##
# MAIN
##

# set the provider features, if any
module "provider_features" {
    source = "./modules/provider-features/azure"
}

# get the resource group
data "azurerm_resource_group" "the_rg" {
    name = var.resource_group_name
}

# create vnet
module "my_vnet" {
  source = "./modules/vnet"
  vnet_name = var.vnet_name
  resource_group_name = data.azurerm_resource_group.the_rg.name
  location = data.azurerm_resource_group.the_rg.location
}

# create gateway subnet
module "sn_gateway" {
    source = "./modules/vnet-subnet"

    subnet_name = "sn-sandbox-jac-gateway"
    resource_group_name = var.resource_group_name
    vnet_name = module.my_vnet.name
    address_prefixes     = ["10.0.2.0/24"]

}

# create

