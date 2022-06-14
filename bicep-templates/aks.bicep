targetScope = 'resourceGroup'

@description('The name of the Managed Cluster resource.')
param aks_name string = 'SCCP-dev-cluster'

@description('The location of AKS resource.')
param location string = 'westeurope'

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string = 'SCCP-dev-cluster-dns'

@description('Disk size (in GiB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@description('The version of Kubernetes.')
param kubernetesVersion string = '1.22.6'

@description('Network plugin used for building Kubernetes network.')
@allowed([
  'azure'
  'kubenet'
])
param networkPlugin string = 'kubenet'

@description('Boolean flag to turn on and off of RBAC.')
param enableRBAC bool = true

@description('Enable private network access to the Kubernetes cluster.')
param enablePrivateCluster bool = false

@description('Boolean flag to turn on and off http application routing.')
param enableHttpApplicationRouting bool = false

@description('Boolean flag to turn on and off Azure Policy addon.')
param enableAzurePolicy bool = false

resource aks 'Microsoft.ContainerService/managedClusters@2022-03-01' = {
  location: location
  name: aks_name
  properties: {
    kubernetesVersion: kubernetesVersion
    enableRBAC: enableRBAC
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: 3
        enableAutoScaling: false
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        osDiskType: 'Managed'
        type: 'VirtualMachineScaleSets'
        mode: 'System'
        maxPods: 110
        availabilityZones: [
          '1'
          '2'
          '3'
        ]
        enableNodePublicIP: false
        tags: {}
      }
      {
        name: 'npstorage'
        osDiskSizeGB: osDiskSizeGB
        count: 3
        enableAutoScaling: false
        vmSize: 'Standard_D2s_v3'
        osType: 'Linux'
        osDiskType: 'Managed'
        type: 'VirtualMachineScaleSets'
        mode: 'User'
        maxPods: 110
        availabilityZones: []
        nodeLabels: {}
        nodeTaints: [
          'storage-node=true:NoSchedule'
        ]
        enableNodePublicIP: false
        tags: {}
      }
    ]
    networkProfile: {
      loadBalancerSku: 'standard'
      networkPlugin: networkPlugin
    }
    apiServerAccessProfile: {
      enablePrivateCluster: enablePrivateCluster
    }
    addonProfiles: {
      httpApplicationRouting: {
        enabled: enableHttpApplicationRouting
      }
      azurepolicy: {
        enabled: enableAzurePolicy
      }
    }
  }
  tags: {}
  identity: {
    type: 'SystemAssigned'
  }
  dependsOn: []
}

// This resource could be used to initialize flux unto the AKS cluster

// resource flux_config 'Microsoft.KubernetesConfiguration/fluxConfigurations@2022-03-01' = {
//   name: 'flux_config'
//   scope: aks
//   properties: {
//     gitRepository: {
//       httpsCACert: 'string'
//       httpsUser: 'string'
//       localAuthRef: 'string'
//       repositoryRef: {
//         branch: 'string'
//         commit: 'string'
//         semver: 'string'
//         tag: 'string'
//       }
//       sshKnownHosts: 'string'
//       syncIntervalInSeconds: int
//       timeoutInSeconds: int
//       url: 'string'
//     }
//     kustomizations: {}
//     namespace: 'flux-system'
//     scope: 'cluster'
//     sourceKind: 'GitRepository'
//     suspend: false
//   }
// }
