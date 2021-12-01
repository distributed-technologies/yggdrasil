<img src="../docs/images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

# Infrastructure CD Workflow
Deploys the both the Azure and helm infrasture using Terraform. 

## Resource Naming
Created resources within Azure uses the following naming convention: <br>
`{ModuleNamePrefix}-{PROJECT_NAME}-{ENVIRONMENT_SHORT}-{ENVIRONMENT_INSTANCE}`

Example:
```yaml
ModuleNamePrefix: nsg (Short for Network Security group)
PROJECT_NAME: eo (Short for Energy Origin)
ENVIRONMENT_SHORT: d (Short for development)
ENVIRONMENT_INSTANCE: '001'
```
would result in: `nsg-eo-d-001`

## Terraform Backend
In order to make it easier to define the Terraform storage name, a search and replace is done during deployment step. 
The naming of the storage name is as followed:

```
tfstate{PROJECT_NAME}{ENVIRONMENT_SHORT}{ENVIRONMENT_INSTANCE}
```

These values is inserted in both `resource_group_name` and `storage_account_name` within the backend files stored at:

- `infrastructure/azure/backend.tf`
- `infrastructure/helm/backend.tf`

## Secrets

### `AZURE_TENANT_ID`
The Azure Tenant id.

### `AZURE_SUBSCRIPTION_ID`
The Azure subscription ID.

### `AZURE_SPN_ID`
The id of the used service principal.

### `AZURE_SPN_SECRET`
The password / secret for the service prinipal.

### `SEALED_SECRET_CRT`
ONLY FOR DEVELOPMENT - sealed-secret base crt.

### `SEALED_SECRET_KEY`
ONLY FOR DEVELOPMENT - sealed-secret base key.

# Helm Chart Version Check Workflow
TODO: Write description for workflow

# Build and release helm chart Workflow
TODO: Write description for workflow

