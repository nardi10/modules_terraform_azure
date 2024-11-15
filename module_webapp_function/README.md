# Terraform Module for Provisioning Web Apps on Azure

This Terraform module provisions and manages the infrastructure needed to create Azure Web Apps/Funtion, including Application Insights, Log Analytics, Service Plans, and subnet configurations. It supports both the creation of new resources and the reuse of existing resources through the provision of IDs, making it flexible for different use cases. This module also allows integration with private endpoints, ensuring your web apps are secure, monitored, and properly scaled.

## Purpose

This module is designed to simplify the deployment and management of Azure Web Apps/Function (Linux or Windows). It automates the configuration of resources such as:

- **Application Insights** for monitoring and diagnostics.
- **Log Analytics Workspace** for detailed metrics and logs.
- **Service Plan** for hosting the Web Apps/Function.
- **Subnets** for network isolation and security, including integration with private endpoints for secure communication.

This module is particularly useful for environments that require scalability, monitoring, and integrated security for Azure Web Apps/Function.

## How to Use

To use this module, import the repository and define the main variables, such as resource names, service plans, network configurations, and app stack (e.g., Dotnet or Python). You can also provide IDs of existing resources if you prefer to reuse resources that have already been deployed.

```hcl
module "webapp" {
  source = "./path-to-module"

  resource_group_name          = "myResourceGroup"
  location                     = "East US"
  tags                         = { Environment = "Production" }
  application_insights_enabled = true
  application_insights_name    = "app-insights-name"
  log_analytics_workspace_name = "log-analytics-workspace"
  service_plan_name            = "service-plan-name"
  service_plan_sku_name        = "F1"
  service_plan_os_type         = "Linux"
  webapp_name                  = { "app1" = "webapp01", "app2" = "webapp02" }
  private_endpoint_name        = { "app1" = "privEndpoint1", "app2" = "privEndpoint2" }
  subnet_address_integration_name = "subnet-integration"
  subnet_address_integration_prefixes = ["10.0.0.0/24"]
  subnet_privatelink_name      = "subnet-privatelink"
  subnet_privatelink_prefixes  = ["10.0.1.0/24"]
  network_security_group_id    = "/subscriptions/.../resourceGroups/myResourceGroup/providers/Microsoft.Network/networkSecurityGroups/myNSG"
}

```

## Main Variables

| **Variable**                         | **Description**                                                            | **Type** | **Default**        |
|--------------------------------------|----------------------------------------------------------------------------|----------|--------------------|
| `resource_group_name`                | The name of the Azure resource group                                         | `string` | -                  |
| `location`                           | The Azure region where the resources will be created                        | `string` | `"East US"`        |
| `tags`                               | Tags to be associated with the resources                                     | `map`    | -                  |
| `application_insights_enabled`       | Whether to enable Application Insights                                      | `bool`   | `true`             |
| `application_insights_name`          | The name of the Application Insights instance                               | `string` | -                  |
| `log_analytics_workspace_name`       | The name of the Log Analytics Workspace for metrics and logs                 | `string` | -                  |
| `service_plan_name`                  | The name of the Azure App Service plan                                      | `string` | -                  |
| `service_plan_sku_name`              | The SKU of the Azure App Service plan (e.g., F1, S1, P1v2)                  | `string` | -                  |
| `service_plan_os_type`               | The operating system type for the service plan (Linux/Windows)              | `string` | `"Linux"`          |
| `webapp_name`                        | Map of the names of the Web Apps/Function to be created                              | `map`    | -                  |
| `private_endpoint_name`              | Map of the names of private endpoints to be created for the Web Apps/Function        | `map`    | -                  |
| `subnet_address_integration_name`    | The name of the subnet for web app integration                              | `string` | -                  |
| `subnet_address_integration_prefixes`| Address prefixes for the subnet where the web app will be integrated        | `list`   | -                  |
| `subnet_privatelink_name`            | The name of the subnet for Private Link integration                         | `string` | -                  |
| `subnet_privatelink_prefixes`        | Address prefixes for the subnet dedicated to Private Link                   | `list`   | -                  |
| `network_security_group_id`          | The ID of the network security group to be associated with the subnets      | `string` | -                  |


## Prerequisites

- **Azure Account**: You need an Azure account with sufficient permissions to create resources such as Web Apps/Function, Service Plans, Application Insights, and network configurations.
- **Log Analytics Workspace**: Ensure that a Log Analytics Workspace is set up if monitoring is required.
- **Private Link Subnets**: Verify that the subnets required for Private Link integration are available or can be created.

## Benefits

- **Scalability**: Easily scale your Web Apps/Function with the Service Plan and configure auto-scaling if needed.
- **Security**: Integrates with private endpoints and Network Security Groups for secure and isolated communication.
- **Monitoring**: With Application Insights and Log Analytics, you can track the performance and logs of your apps in real-time.
- **Flexibility**: Supports both the creation of new resources and the reuse of existing resources, providing flexibility in configuring your infrastructure.
