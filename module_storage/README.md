## Azure Private Endpoint Terraform Module for Storage Account

This module provisions a Private Endpoint to securely connect to an Azure Storage Account using Azure Private Link. The connection is made to the Blob service of the storage account over a private network, ensuring that the traffic does not traverse the public internet.

### Example Usage

```hcl
module "private_endpoint_storage" {
  source                = "./path-to-module"  # Provide the path to the module
  private_endpoint_name = "my-private-endpoint"
  resource_group_name   = "my-resource-group"
  location              = "East US"
  subnet_address_id     = "subnet-id"
  tags                  = { Environment = "Production" }
}

```

### Main Variables

| Variable               | Description                                           | Type      | Default    |
|------------------------|-------------------------------------------------------|-----------|------------|
| `private_endpoint_name` | The name of the private endpoint                      | string    | -          |
| `resource_group_name`   | The name of the Azure resource group                  | string    | -          |
| `location`              | The Azure region where the resources will be created  | string    | "East US"  |
| `subnet_address_id`     | The subnet ID where the private endpoint will be deployed | string  | -          |
| `tags`                  | Tags to be associated with the resources              | map(any)  | -          |

### Configured Components

- `azurerm_private_endpoint`: Provisions a private endpoint to securely connect to an Azure Storage Account.

### Outputs

- `private_endpoint_id`: The ID of the created private endpoint.
- `private_endpoint_name`: The name of the created private endpoint.

### Prerequisites

- **Azure Account**: You must have an Azure account with sufficient permissions to create private endpoints and storage accounts.
- **Virtual Network and Subnet**: A Virtual Network and Subnet must exist for deploying the private endpoint. Ensure that Private Link is configured properly.
- **Storage Account**: An Azure Storage Account must already exist or be specified.

### Benefits

- **Security**: Ensures secure access to the Storage Account through private IPs, avoiding exposure to the public internet.
- **Compliance**: Provides secure, private access to Azure Storage services, meeting compliance requirements for data protection.
- **Scalability**: Easily scalable by adding private endpoints for different services, enhancing overall infrastructure security.
- **Performance**: Helps in reducing latency and improving security by avoiding public internet routes for service access.
