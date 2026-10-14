# AzureGoat Vulnerable Infrastructure Reference Manifest
# Illustrates the 4 core vulnerabilities explored in the lab:
# 1. Azure Function with System-Assigned Managed Identity & Overprivileged RBAC
# 2. Azure Storage Account with Insecure Public SAS Token & Blob Exposure
# 3. Entra ID (Azure AD) App Registration with excessive Microsoft Graph permissions
# 4. CosmosDB key leakage via Function Environment variables

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}

variable "resource_group_name" {
  type    = string
  default = "cyberlab-azuregoat-rg"
}

variable "location" {
  type    = string
  default = "eastus"
}

# --- Vulnerability 1: Overprivileged App Registration in Entra ID ---
# App has RoleManagement.ReadWrite.Directory or AppRoleAssignment.ReadWrite.All
resource "azuread_application" "vulnerable_ci_app" {
  display_name = "cyberlab-internal-deployer"
  # Insecure: any member of the directory can create client credentials if allowed by tenant settings
}

# --- Vulnerability 2: Insecure Storage Account & SAS Generation ---
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "goat_storage" {
  name                     = "cyberlabgoatstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Insecure: Allows public HTTP traffic and broad access
  enable_https_traffic_only = false
}

resource "azurerm_storage_container" "confidential_blobs" {
  name                  = "confidential-backups"
  storage_account_name  = azurerm_storage_account.goat_storage.name
  container_access_type = "private"
}

# --- Vulnerability 3: Azure Function with Managed Identity ---
# The function contains an SSRF flaw that allows querying IMDS (169.254.169.254)
# to obtain an OAuth2 access token for the management plane.
resource "azurerm_service_plan" "plan" {
  name                = "azuregoat-sp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "ssrf_function" {
  name                = "cyberlab-azuregoat-func"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id

  storage_account_name       = azurerm_storage_account.goat_storage.name
  storage_account_access_key = azurerm_storage_account.goat_storage.primary_access_key

  # System-Assigned Managed Identity is enabled
  identity {
    type = "SystemAssigned"
  }

  site_config {}
}

# --- Vulnerability 4: Overprivileged Role Assignment to Managed Identity ---
# The function is granted 'Contributor' role on the entire subscription/resource group
resource "azurerm_role_assignment" "overprivileged_role" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_function_app.ssrf_function.identity[0].principal_id
}
