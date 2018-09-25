#Requires -Modules Pester

# Obtain name of this file
$ThisFile = $PSCommandPath -replace '\.Tests\.ps1$'
$ThisFileName = $ThisFile | Split-Path -Leaf

Describe "Tests" {
    Context "Test $ThisFileName Functions" {
        It "Export-ITGlueModuleSettings should export config.psd1 file" {
            # Test APIkey test
            Add-ITGlueAPIKey -Api_Key 'APIkeytest'

            Export-ITGlueModuleSettings
            $outputPath = "$($env:USERPROFILE)\ITGlueAPI"
            $outputPath+"\config.psd1" | Should -Exist
        }
        It "Import-ITGlueModuleSettings should import configuration and populate variables" {
            # Test for presence of variable and remove for basic and incomplete test import process 
            if ($ITGlue_API_Key) {
                Remove-ITGlueAPIKey
            }
            Import-ITGlueModuleSettings        
            Get-ITGlueAPIKey | Should -Not -BeNullOrEmpty
            $ITGlue_JSON_Conversion_Depth | Should -Not -BeNullOrEmpty
            $ITGlue_Base_URI | Should -Not -BeNullOrEmpty
        }
    }
}