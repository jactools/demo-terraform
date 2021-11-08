terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.84.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  environment = "public"
  features {
    #
    api_management {
        purge_soft_delete_on_destroy = false
    }
    #
    key_vault {
        recover_soft_deleted_key_vaults = true
    }
    #
    log_analytics_workspace {
        permanently_delete_on_destroy = false
    }
    #
    resource_group {
        prevent_deletion_if_contains_resources = true
    }
    #
    virtual_machine {
        delete_os_disk_on_deletion = true
        graceful_shutdown = false
        skip_shutdown_and_force_delete = false
    }
  }

}
