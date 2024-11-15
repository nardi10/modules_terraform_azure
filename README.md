# Terraform Azure Infrastructure Module

This repository provides Terraform modules for provisioning and managing various Azure resources, such as Virtual Machines (VMs), Virtual Networks (VNets), Subnets, Network Security Groups (NSGs), and more.

## Best Practices

Each resource should be deployed following **Azure best practices** for security, scalability, and performance. Please ensure you review and apply best practices in the respective resource folders.

## Resource Folders

Detailed documentation for each type of resource is located in the corresponding subfolder. Please refer to these folders for specific instructions on how to configure and deploy each resource type. The main folders include:

- **/module_virtual_machines**: Virtual Machines (VMs)
- **/module_webapp_function**: Virtual Networks (VNETs) and Subnets
- **/module_networksecuritygroup**: Network Security Groups (NSGs) and related configurations
- **/storage**: Azure Storage Accounts
- **/monitoring**: Application Insights and Log Analytics for monitoring and logging
- **/other-resources**: Additional resources as needed

## How to Use

Each folder contains the necessary Terraform configurations and example files for deploying the respective resources. You can import these modules into your Terraform configuration and define your desired variables.

Please review the README and configuration files in each folder for detailed usage instructions.

## Conclusion

This repository helps automate the deployment of Azure resources while adhering to best practices. By exploring the resource-specific folders, you'll find all the details you need to configure and manage your infrastructure efficiently.
