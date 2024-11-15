# Azure SQL Server and Private Endpoint Terraform Module

This module provisions an Azure SQL Server and its associated private endpoint to securely connect to the server within a virtual network. It includes the configuration of the private endpoint for SQL Server, ensuring secure and isolated access to the database server over a private IP.

## Example Usage

```hcl
module "sqlserver_with_private_endpoint" {
  source                     = "./path-to-module"  # Provide the path to the module
  private_endpoint_name       = "my-private-endpoint"
  sqlserver_name              = "my-sqlserver"
  resource_group_name         = "my-resource-group"
  location                    = "East US"
  subnet_address_id           = "subnet-id"
  administrator_login         = "adminuser"
  administrator_login_password = "adminpassword"
  tags                        = { Environment = "Production" }
}

```

## Main Variables

| **Variable**                   | **Description**                                                       | **Type**   | **Default**        |
|---------------------------------|-----------------------------------------------------------------------|-----------|--------------------|
| `private_endpoint_name`         | The name of the private endpoint for SQL Server                       | `string`   | -                  |
| `sqlserver_name`                | The name of the SQL Server                                            | `string`   | -                  |
| `resource_group_name`           | The name of the Azure resource group                                  | `string`   | -                  |
| `location`                      | The Azure region where the resources will be created                  | `string`   | `"East US"`        |
| `subnet_address_id`             | The subnet ID where the private endpoint will be deployed             | `string`   | -                  |
| `administrator_login`           | The administrator login for SQL Server                                | `string`   | -                  |
| `administrator_login_password`  | The administrator login password for SQL Server                       | `string`   | -                  |
| `tags`                          | Tags to be associated with the resources                              | `map(any)` | -                  |


## Configured Components

- **azurerm_mssql_server**: Provisions an Azure SQL Server with specified configurations like version, administrator login, and access control.
- **azurerm_private_endpoint**: Creates a private endpoint to securely connect to the SQL Server over a private network.

## Outputs

- `sqlserver_id`: The ID of the created SQL Server resource.
- `private_endpoint_id`: The ID of the created private endpoint.
- `sqlserver_name`: The name of the created SQL Server.

## Prerequisites

- **Azure Account**: You must have an Azure account with sufficient permissions to create SQL Servers, Private Endpoints, and associated resources.
- **Virtual Network and Subnet**: A Virtual Network and Subnet must exist for deploying the private endpoint. Ensure that Private Link is configured properly.
- **Resource Group**: A resource group must already exist or be specified for resource deployment.

## Benefits

- **Security**: The private endpoint ensures secure access to the SQL Server within a Virtual Network, preventing exposure to the public internet.
- **Access Control**: Configures SQL Server access with custom administrator logins and provides fine-grained access control.
- **Compliance**: Ensures compliance by securing connections to the SQL Server with encryption (TLS 1.2) and private access.
- **Scalability**: Easily scalable by adjusting SQL Server configurations, and adding private endpoints to other services within your infrastructure.

