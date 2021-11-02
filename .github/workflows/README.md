<img src="../docs/images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

# Infrastructure CD Workflow
Deploys the both the Azure and helm infrasture using Terraform. 

## Resource Naming
Created resources within Azure uses the following naming convention: <br>
`{ModuleNamePrefix}-{PROJECT_NAME}-{ENVIRONMENT_SHORT}-{ENVIRONMENT_INSTANCE}`

Example:
```yaml
ModuleNamePrefix: nsg (Short for Network Security group)
PROJECT_NAME: ett (Short for Energy-Track-And-Trace)
ENVIRONMENT_SHORT: d (Short for development)
ENVIRONMENT_INSTANCE: '001'
```
would result in: `nsg-ett-d-001`

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

### `AZURE_RG_NAME`
The Azure resource group name.

### `AZURE_SPN_ID`
The id of the used service principal.

### `AZURE_SPN_OBJECT_ID`
The Azure object id of the used serivce principal.

### `AZURE_SPN_SECRET`
The password / secret for the service prinipal .

### `AZURE_SUBSCRIPTION_ID`
The Azure subscription ID.

### `TERRAFORM_STATE_RG_NAME`
The Azure resource group name, used for storing Terraform states.

### `AZURE_TENANT_ID`
The Azure Tenant id.

### `ORGANIZATION_NAME`
Name or abbreviation of the organization.  

# Helm Chart Version Check Workflow
TODO: Write description for workflow

# Build and release helm chart Workflow
TODO: Write description for workflow

