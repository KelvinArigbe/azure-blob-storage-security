param(
    [string]$ResourceGroup = "rg-storage-security-lab",
    [string]$StorageAccount = "stseclab7k92m46"
)

$storageJson = az storage account show `
    --resource-group $ResourceGroup `
    --name $StorageAccount `
    --output json

if ($LASTEXITCODE -ne 0) {
    throw "Could not retrieve the storage account configuration."
}

$storage = $storageJson | ConvertFrom-Json -ErrorAction Stop

if ($null -eq $storage) {
    throw "No storage account configuration returned."
}

if ($storage.allowBlobPublicAccess -eq $false) {
    "PASS: Anonymous access is disabled"
} else {
    "REVIEW: Anonymous access is enabled or not explicitly disabled"
}

if ($storage.allowSharedKeyAccess -eq $false) {
    "PASS: Shared Key access is disabled"
} else {
    "REVIEW: Shared Key access is enabled or not explicitly disabled"
}

if ($storage.defaultToOAuthAuthentication -eq $true) {
    "PASS: Entra authentication is the portal default"
} else {
    "REVIEW: Entra authentication is not the portal default"
}

if ($storage.enableHttpsTrafficOnly -eq $true) {
    "PASS: HTTPS is required"
} else {
    "REVIEW: HTTPS is not explicitly required"
}

if ($storage.minimumTlsVersion -eq "TLS1_2") {
    "PASS: Minimum TLS is 1.2"
} else {
    "REVIEW: Check the minimum TLS version"
}
