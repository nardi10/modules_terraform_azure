# Terraform Module for Provisioning Azure Key Vault with Private Endpoint

This module provisions an Azure Key Vault and creates a private endpoint for secure access. The private endpoint ensures that the Key Vault can be accessed only through a private network, enhancing security by avoiding public internet access.

## Purpose

This module is designed to automate the provisioning of an Azure Key Vault and its integration with a private endpoint. The Key Vault is used for storing sensitive data, such as secrets, keys, and certificates, while the private endpoint ensures that access to the Key Vault is restricted to private IPs within a Virtual Network.

## Resources

### `azurerm_key_vault`
- **Purpose**: Provision an Azure Key Vault for storing and managing sensitive information such as secrets, keys, and certificates.
- **Features**:
  - **Soft delete** and **purge protection** are enabled to safeguard against accidental deletions.
  - **Network ACLs** are configured to limit access, and only specified IP ranges are allowed.
  - The vault is configured to support disk encryption.

### `azurerm_private_endpoint`
- **Purpose**: Creates a private endpoint to securely access the Key Vault using a private IP within a Virtual Network.
- **Private Service Connection**:
  - Configures the connection to the Key Vault resource.
  - Ensures no manual connection is required (auto connection).
  - The private endpoint is restricted to accessing the Key Vault (Vault subresource).

### `azurerm_key_vault_access_policy`
- **Purpose**: Configures access policies to the Key Vault for specific users or services. In this case, the policy is set to allow reading keys and secrets.
- **Permissions**:
  - Allows **"Get"** permission for both keys and secrets, ensuring controlled access to sensitive data.

## How to Use

To use this module, define the required variables such as the Key Vault name, private endpoint name, and the network configuration. The module will automatically create the necessary resources, including the Key Vault, Private Endpoint, and access policies.

### Example Usage:

```hcl
module "key_vault_with_private_endpoint" {
  source = "./path-to-module"

  key_vault_name        = "my-keyvault"
  resource_group_name   = "myResourceGroup"
  location              = "East US"
  private_endpoint_name = "myPrivateEndpoint"
  subnet_address_id     = "/subscriptions/.../resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVNet/subnets/mySubnet"
  tags                  = { Environment = "Production" }
}

```

## Main Variables

| **Variable**            | **Description**                                                    | **Type**     | **Default**        |
|-------------------------|--------------------------------------------------------------------|--------------|--------------------|
| `key_vault_name`         | The name of the Key Vault                                          | `string`     | -                  |
| `tags`                   | Tags to be associated with the resources                           | `map(any)`   | -                  |
| `resource_group_name`    | The name of the Azure resource group                               | `string`     | -                  |
| `location`               | The Azure region where the resources will be created               | `string`     | `"East US"`        |
| `private_endpoint_name`  | The name of the private endpoint                                   | `string`     | -                  |
| `subnet_address_id`      | The subnet ID where the private endpoint will be deployed          | `string`     | -                  |

## Configured Components

- **azurerm_key_vault**: Provisions a Key Vault resource for storing and managing sensitive data.
- **azurerm_private_endpoint**: Creates a private endpoint to access the Key Vault securely within a private network.
- **azurerm_key_vault_access_policy**: Configures access policies for the Key Vault, allowing specific permissions to users or services.

## Outputs

- **key_vault_id**: The ID of the created Key Vault resource.
- **private_endpoint_id**: The ID of the created private endpoint resource.
- **key_vault_uri**: The URI of the created Key Vault.

## Prerequisites

- **Azure Account**: You must have an Azure account with sufficient permissions to create resources such as Key Vault, Private Endpoint, and associated networking components.
- **Virtual Network and Subnet**: A Virtual Network and Subnet must be available for deploying the private endpoint. If they don't exist, you must create them.
- **Private Link Configuration**: Ensure that Private Link is properly configured to allow communication between the Virtual Network and Azure services like Key Vault.

## Benefits

- **Security**: Ensures secure access to the Key Vault by restricting access to private IPs within a Virtual Network, avoiding exposure to the public internet.
- **Access Control**: Fine-grained access policies allow you to control who can access keys and secrets stored in the Key Vault.
- **Compliance**: With features like soft delete and purge protection, this configuration helps meet compliance requirements for managing sensitive data.
- **Scalability**: Easily scalable to accommodate multiple key vaults and private endpoints for various services within your infrastructure.
