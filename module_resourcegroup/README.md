## Azure Resource Group Terraform Module

This module provisions an Azure Resource Group to organize and manage resources in your Azure subscription. The Resource Group is a container that holds related resources for an Azure solution.

### Example Usage

```hcl
module "resource_group" {
  source              = "./path-to-module"  # Provide the path to the module
  resource_group_name = "my-resource-group"
  location            = "East US"
  tags                = { Environment = "Production" }
}

```

### Main Variables

| **Variable**           | **Description**                                        | **Type**   | **Default** |
|------------------------|--------------------------------------------------------|------------|-------------|
| `resource_group_name`   | The name of the Azure resource group                   | `string`   | -           |
| `location`              | The Azure region where the resource group will be created | `string`   | `"East US"` |
| `tags`                  | Tags to be associated with the resources               | `map(any)` | -           |


### Configured Components

- **azurerm_resource_group**: Provisions an Azure Resource Group.

### Outputs

- `resource_group_id`: The ID of the created Resource Group.
- `resource_group_name`: The name of the created Resource Group.

### Prerequisites

- **Azure Account**: You must have an Azure account with sufficient permissions to create Resource Groups.
- **Location**: The location (region) for the Resource Group must be specified.

### Benefits

- **Organized Resource Management**: Allows you to group resources logically for easier management and access control.
- **Centralized Management**: Helps in managing resources and their lifecycle within a specific region.
- **Cost Control**: Organize resources in a Resource Group to apply cost management and billing effectively.
