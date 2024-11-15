## Azure Log Analytics Workspace Terraform Module

This module provisions a Log Analytics Workspace on Azure for collecting and analyzing log and telemetry data from your resources. The Log Analytics Workspace is used for monitoring and troubleshooting, providing insights into resource performance and health.

### Example Usage

To use the module, reference it in your Terraform configuration, define the required variables, and apply it to your environment.

```hcl
module "log_analytics_workspace" {
  source                        = "./path-to-module"  # Provide the path to the module
  log_analytics_workspace_name   = "my-log-analytics-workspace"
  resource_group_name            = "my-resource-group"
  location                       = "East US"
  sku                            = "PerGB2018"
  retention_in_days              = 30
  tags                           = { Environment = "Production" }
}

```

### Main Variables

| **Variable**                        | **Description**                                                            | **Type**   | **Default**        |
|-------------------------------------|----------------------------------------------------------------------------|-----------|--------------------|
| `log_analytics_workspace_name`      | The name of the Log Analytics Workspace                                     | `string`  | -                  |
| `tags`                              | Tags to be associated with the resources                                    | `map(any)` | -                  |
| `resource_group_name`               | The name of the Azure resource group                                        | `string`  | -                  |
| `location`                          | The Azure region where the resources will be created                        | `string`  | `"East US"`        |
| `sku`                                | The SKU of the Log Analytics Workspace (e.g., PerGB2018)                    | `string`  | `"PerGB2018"`      |
| `retention_in_days`                 | The retention period for the logs in the workspace (in days)                | `number`  | `30`               |

### Configured Components

- `azurerm_log_analytics_workspace`: Provisions the Log Analytics Workspace to store and analyze log data from your Azure resources.

### Outputs

- `log_analytics_workspace_id`: The ID of the created Log Analytics Workspace.
- `log_analytics_workspace_name`: The name of the created Log Analytics Workspace.

### Prerequisites

- **Azure Account**: You must have an Azure account with sufficient permissions to create resources like Log Analytics Workspaces.
- **Resource Group**: A resource group must already exist, or you can specify a new one.

### Benefits

- **Centralized Monitoring**: Collect logs and performance data from multiple Azure resources in one place for easier monitoring and analysis.
- **Advanced Querying**: Use Kusto Query Language (KQL) to run complex queries and get detailed insights into your resources.
- **Retention and Scalability**: Customize retention periods and scale to store vast amounts of data, depending on your organization's needs.
- **Integration**: Seamlessly integrates with other Azure services for advanced monitoring, alerting, and automation workflows.
