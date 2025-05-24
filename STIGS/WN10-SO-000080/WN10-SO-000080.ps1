<#
.SYNOPSIS
    This script configures the Windows login screen to display a legal notice caption, specifically the "DoD Notice and Consent Banner," by modifying the registry.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-04-27
    Last Modified   : 2025-04-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000080

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000080.ps1 
#>
 
 
 $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "LegalNoticeCaption"
$regValue = "DoD Notice and Consent Banner"

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue

Write-Host "'Interactive logon: Message title' successfully set to: '$regValue'"
 
