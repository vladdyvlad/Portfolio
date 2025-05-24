 <#
.SYNOPSIS
    This script ensures that telemetry data sent to Microsoft is limited by setting the AllowTelemetry registry key. The default value here is 1 (Basic), but can be adjusted for stricter compliance (0 for Security).

.NOTES
    Author          : Vladimir 
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000205.ps1 
#>



# Ensure the script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# Registry path and values
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\DataCollection"
$regName = "AllowTelemetry"
$regValue = 1  # 0 = Security, 1 = Basic, 2 = Enhanced

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    try {
        New-Item -Path $regPath -Force | Out-Null
        Write-Host "Created registry path: $regPath"
    } catch {
        Write-Error "Failed to create registry path: $_"
        exit 1
    }
}

# Apply the telemetry policy setting
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Host "'Allow Telemetry' successfully set to $regValue (`Basic`). You can change it to 0 (`Security`) or 2 (`Enhanced`) if required."
} catch {
    Write-Error "Failed to set registry value: $_"
}
 
