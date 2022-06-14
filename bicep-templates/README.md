# Deploying using Bicep

Currently one way to use bicep as a deployment method we can run the cmd blow.

Changing only the `resource-group` to the resource-group of your choosing.

There is also a lot of other parameters to change one could be `aks_name` which changes the name of the cluster

``` sh
az deployment group create \
  --resource-group mht-playground \
  --template-file 'bicep-templates/aks.bicep' \
  --parameters aks_name='SCCP-dev-cluster'
```
