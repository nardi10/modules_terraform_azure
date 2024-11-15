# Terraform Module for Provisioning Linux Virtual Machines on Azure

This Terraform module creates and manages infrastructure for Linux virtual machines on Azure. The objective is to provision VMs with network configurations, automated backup, and monitoring. This module is ideal for environments that require scalability, backup management, and integrated monitoring.

## Purpose

The module was developed to simplify the provisioning of Linux VMs on Azure, setting up all necessary components for a secure and manageable IaaS environment. In addition to VMs, the module configures:

- Network Interface (NIC) with dynamic IP.
- Automated VM backup using Azure Backup.
- Monitoring with Log Analytics integration, utilizing the **OmsAgentForLinux** extension.

## How to Use

To use the module, import the repository and define the main variables, such as VM names, size, credentials, image, and network configuration.

```hcl
module "linux_vm" {
  source = "./path-to-module"

  virtual_machine_name          = { "vm1" = "vm01", "vm2" = "vm02" }
  resource_group_name           = "myResourceGroup"
  location                      = "East US"
  size                          = "Standard_DS1_v2"
  admin_username                = "adminuser"
  admin_password                = "Password123!"
  storage_account_type          = "Standard_LRS"
  vm_image_id                   = null
  vm_image                      = {
      offer     = "UbuntuServer",
      publisher = "Canonical",
      sku       = "18.04-LTS",
      version   = "latest"
  }
  subnet_address_id             = "/subscriptions/.../subnets/subnet1"
  recovery_services_vault_name  = "myRecoveryVault"
  backup_policy_id              = "/subscriptions/.../backupPolicies/policy1"
  log_analytics_workspace_id    = "/subscriptions/.../workspace/workspace1"
  log_analytics_workspace_key   = "workspaceKey"
  tags                          = { Environment = "Production" }
}

```
# Terraform Module for Provisioning Windows Virtual Machines on Azure

This Terraform module provisions and manages infrastructure for Windows virtual machines (VMs) on Azure. The module creates VMs with network configurations, automated backup, and monitoring. It is ideal for scalable and manageable infrastructure in Azure environments.

## Purpose

The module simplifies the provisioning of Windows VMs on Azure, setting up all necessary components for a secure IaaS environment. In addition to provisioning the VMs, the module configures:

- Network Interface (NIC) with dynamic IP.
- Automated VM backup using Azure Backup.
- Monitoring with Log Analytics integration, utilizing the **AzureMonitorWindowsAgent** and **MicrosoftMonitoringAgent** extensions.

## How to Use

To use the module, import the repository and define the main variables like VM names, size, credentials, image, and network configuration.

```hcl

module "windows_vm" {
  source = "./path-to-module"

  virtual_machine_name          = { "vm1" = "vm01", "vm2" = "vm02" }
  resource_group_name           = "myResourceGroup"
  location                      = "East US"
  size                          = "Standard_DS1_v2"
  admin_username                = "adminuser"
  admin_password                = "Password123!"
  storage_account_type          = "Standard_LRS"
  vm_image_id                   = null
  vm_image                      = {
      offer     = "WindowsServer",
      publisher = "MicrosoftWindowsServer",
      sku       = "2019-Datacenter",
      version   = "latest"
  }
  subnet_address_id             = "/subscriptions/.../subnets/subnet1"
  recovery_services_vault_name  = "myRecoveryVault"
  backup_policy_id              = "/subscriptions/.../backupPolicies/policy1"
  log_analytics_workspace_id    = "/subscriptions/.../workspace/workspace1"
  log_analytics_workspace_key   = "workspaceKey"
  tags                          = { Environment = "Production" }
}

```

## Prerequisites
Configured Azure account with sufficient permissions to create resources.
The module requires that the Log Analytics Workspace and Recovery Services Vault are already set up for monitoring and backup.

## Main Variables

| **Variable**                    | **Description**                                                            | **Type** | **Default**        |
|----------------------------------|----------------------------------------------------------------------------|----------|--------------------|
| `virtual_machine_name`           | Map with the names of the VMs to be created                                | `map`    | -                  |
| `resource_group_name`            | Name of the Azure resource group                                           | `string` | -                  |
| `location`                       | Azure region where resources will be created                               | `string` | `"East US"`        |
| `size`                           | Size of the virtual machine                                                | `string` | -                  |
| `admin_username`                 | Admin username for the VM                                                 | `string` | -                  |
| `admin_password`                 | Administrator password for the VM                                          | `string` | -                  |
| `storage_account_type`           | Storage account type for the VM's OS disk                                  | `string` | `"Standard_LRS"`   |
| `vm_image`                       | VM image settings, including publisher, offer, SKU, and version            | `map`    | -                  |
| `log_analytics_workspace_id`     | ID of the Log Analytics Workspace for monitoring                           | `string` | -                  |
| `log_analytics_workspace_key`    | Key for authenticating with the Log Analytics Workspace                    | `string` | -  


## Configured Components

- **azurerm_linux_virtual_machine/azurerm_windows_virtual_machine**: Provisiona a máquina virtual com o disco do sistema operacional configurado.
- **azurerm_network_interface**: Cria e configura a interface de rede para as VMs.
- **azurerm_backup_protected_vm**: Habilita o backup automatizado das VMs no Azure.
- **azurerm_virtual_machine_extension**: Adiciona a extensão **OmsAgentForLinux** para integração com o Log Analytics.
