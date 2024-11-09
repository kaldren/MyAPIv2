// Deploy ../MyAPI to Azure App Service using Bicep
targetScope='subscription'

param webAppName string = 'app-myapi-prd-eastus'
param location string = 'East US'

// Create resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-${webAppName}'
  location: location
}

// Create App Service Plan
resource appServicePlan 'Microsoft.Web/serverFarms@2024-03-01' = {
  name: 'plan-${webAppName}'
  location: location
  sku: {
    name: 'S1'
  }
}

// Create Web App
resource webApp 'Microsoft.Web/sites@2024-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
