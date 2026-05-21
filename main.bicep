param location string = resourceGroup().location
param baseName string
 
// Slices the resource group unique string to ensure strict character counts
var shortHash = take(uniqueString(resourceGroup().id), 8)
var shortBase = take(baseName, 10)
 
// Guaranteed to be under 24 characters: 2 (st) + 8 (hash) + 10 (base) = 20 total
var storageName = 'st${shortHash}${shortBase}'
var planName = 'asp-${shortBase}-${shortHash}'
var webAppName = 'app-${shortBase}-${shortHash}'
 
module storage './modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    location: location
    storageAccountName: storageName
  }
}
 
module webapp './modules/webapp.bicep' = {
  name: 'webAppDeployment'
  params: {
    location: location
    appServicePlanName: planName
    webAppName: webAppName
  }
}
 
 
