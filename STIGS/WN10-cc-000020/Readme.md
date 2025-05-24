# Disable IP Source Routing (IPv6)

This PowerShell script configures the system to **disable IP source routing for IPv6** by setting the appropriate registry value, ensuring compliance with [STIG-ID: WN10-CC-000020](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r8.audit:8a9f4554f9e8f0402562c9698d6d54e9).

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/54785d4d-c9a0-4328-a3e4-9071115f9bf0)

**After**

![Image](https://github.com/user-attachments/assets/5bed960b-74b2-44b6-807a-d354d4d9e6fb)

> Replace these placeholders with registry screenshots before and after applying the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-CC-000020  
- **Description**: IPv6 source routing must be configured to the highest protection level (disabled).  
- **Fix**: This script disables IP source routing by configuring the relevant registry setting.  
- **Impact**: Medium

---

## 🧠 Synopsis

Disabling IP source routing helps prevent spoofing and packet redirection attacks. This script enforces the **highest protection (value: 2)** for IPv6 routing.

---

## 📜 Script

 <#
.SYNOPSIS
   Disabling IP source routing helps prevent spoofing and packet redirection attacks. This script enforces the **highest protection (value: 2)** for IPv6 routing.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000020.ps1 
#>

# Check for MSS-Legacy ADMX/ADML presence (informational only)

# Ensure the script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# Check for MSS-Legacy ADMX/ADML presence (informational only)
$admx = "$env:SystemRoot\PolicyDefinitions\MSS-Legacy.admx"
$adml = "$env:SystemRoot\PolicyDefinitions\en-US\MSS-Legacy.adml"

if (!(Test-Path $admx) -or !(Test-Path $adml)) {
    Write-Warning "MSS-Legacy templates not found. These are only required for GPO UI visibility, not for registry-based enforcement."
}

# Registry configuration
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$regName = "DisableIPSourceRouting"
$regValue = 2  # 2 = Highest protection (completely disabled)

# Create registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    try {
        New-Item -Path $regPath -Force | Out-Null
        Write-Host "Created registry path: $regPath"
    } catch {
        Write-Error "Failed to create registry path: $_"
        exit 1
    }
}

# Apply the registry setting
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Host "'DisableIPSourceRouting (IPv6)' set to 2 (Highest protection) as per STIG requirements."
} catch {
    Write-Error "Failed to set registry value: $_"
}
 
