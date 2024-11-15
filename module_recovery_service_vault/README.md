## Azure Backup and Recovery Services Vault Terraform Module

This module provisions the necessary resources for backup and recovery in Azure, including a Recovery Services Vault, Backup Policy for VMs, and Diagnostic Settings for logging. The resources are configured for automated daily backups with retention policies.

### Example Usage

```hcl
module "backup_recovery_services" {
  source                        = "./path-to-module"  # Provide the path to the module
  recovery_services_vault_name   = "my-recovery-vault"
  resource_group_name            = "my-resource-group"
  location                       = "East US"
  backup_policy_name             = "my-backup-policy"
  tags                           = { Environment = "Production" }
}

```

### Main Variables

| **Variable**                        | **Description**                                                | **Type**   | **Default**  |
|-------------------------------------|----------------------------------------------------------------|-----------|--------------|
| `recovery_services_vault_name`      | The name of the Recovery Services Vault                        | `string`  | -            |
| `resource_group_name`               | The name of the Azure resource group                           | `string`  | -            |
| `location`                          | The Azure region where the resources will be created           | `string`  | `"East US"`  |
| `backup_policy_name`                | The name of the Backup Policy for VMs                          | `string`  | -            |
| `tags`                              | Tags to be associated with the resources                       | `map(any)` | -            |

### Prerequisites

- **Azure Account**: You must have an Azure account with sufficient permissions to create resources such as Recovery Services Vaults, Backup Policies, and Diagnostic Settings.
- **Resource Group**: A resource group must already exist or be specified.

### Benefits

- **Backup and Disaster Recovery**: Ensure that your virtual machines are backed up regularly and can be restored in case of failure.
- **Retention and Recovery**: Customize retention policies for daily backups, and ensure the recovery of your data over a period of time.
- **Monitoring and Diagnostics**: Automatically configure monitoring for logs and metrics related to the Recovery Services Vault.
- **Security and Compliance**: Provides soft delete functionality and encryption options to meet security and compliance standards for data protection.

