# File helps to run tests

# If module is loaded, then force remove it
If (Get-Module ITGlueAPI) {
    Remove-Module -Force ITGlueAPI
}
# Load moddule via relative path
Import-Module ..\ITGlueAPI.psd1

# Report loaded module details
Get-Module ITGlueAPI

# Run tests
.\ModuleSettings.Tests.ps1
.\ITGlueAPI.Tests.ps1

# Remove API Key before running the APIKey test
if ($ITGlue_API_Key) {
    Remove-ITGlueAPIKey
}
.\APIKey.Tests.ps1

# Run more tests
.\BaseURI.Tests.ps1