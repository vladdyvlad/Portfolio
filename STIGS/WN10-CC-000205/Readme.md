# Configure Windows Telemetry Level

This PowerShell script enforces a compliant Windows telemetry level by modifying registry settings in accordance with [STIG ID: WN10-CC-000205](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r8.audit:45d0d370dc40bfffeb6eb1d400410574).

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/e2013faa-bf63-4106-9f20-40ddd8383e06)

**After**

![Image](https://github.com/user-attachments/assets/e94b99c0-5112-4e9d-a9e0-abefe30e61b5)

> Use screenshots of registry values before and after applying the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-CC-000205  
- **Description**: Windows 10/11 systems must limit telemetry to the minimum level (Security, Basic, or Enhanced).  
- **Fix**: This script configures the `AllowTelemetry` registry setting.  
- **Impact**: Medium

---

## 🧠 Synopsis

This script ensures that telemetry data sent to Microsoft is limited by setting the `AllowTelemetry` registry key. The default value here is `1` (Basic), but can be adjusted for stricter compliance (`0` for Security).

---

## 📜 Script

```powershell
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
 
