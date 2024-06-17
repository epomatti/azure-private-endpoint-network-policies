# Azure Private Endpoints security

Protecting outbound traffic by using Application Security Groups (ASG) with Private Endpoints.

> [!IMPORTANT]
> The [documentation][1] defines the following:
> > This setting only applies to private endpoints in the subnet and affects all private endpoints in the subnet. For other resources in the subnet, access is controlled based on security rules in the network security group.

> [!NOTE]
> Network Security Group rules using application security groups may only be applied when the ASGs are associated with network interfaces on the same virtual network.

## Infrastructure

Create the `.auto.tfvars` file and add your public IP:

```terraform
allowed_public_ip_address = "you IP"
```

Create the resources:

```sh
terraform init
terraform apply -auto-approve
```

## Testing

Log into the virtual machine and enable the Azure CLI with the System-Assigned identity:

```sh
az login --identity
```

Attempt to connect to the storages. Storage `001` should work, and storage `002` should fail:

```sh
# This should work
az storage blob list --auth-mode login --account-name stcontosos35001 --container data

# This should fail
az storage blob list --auth-mode login --account-name stcontosos35002 --container data
```

Additionally, test the connectivity to the SQL Database via Private Link.


[1]: https://learn.microsoft.com/en-us/azure/private-link/disable-private-endpoint-network-policy?tabs=network-policy-portal
