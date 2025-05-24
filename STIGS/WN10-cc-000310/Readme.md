# 🚫 Disable User Control Over Installs

This PowerShell script disables user control over Windows Installer installs, enforcing the configuration outlined in [STIG ID: WN10-CC-000310](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r8.audit:0553472cb9b0a2d600e4fd7353408f2e).

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/7292e314-14d2-4440-a35f-0cfc31ca7277)

**After**

![Image](https://github.com/user-attachments/assets/ada3ab48-d27f-4a5e-ba56-f27be21f82ae)

> Use screenshots of the registry key before and after running the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-CC-000310  
- **Description**: User control over Windows Installer installs must be disabled to prevent unauthorized software installations.  
- **Fix**: This script sets the registry value `EnableUserControl` to `0` under the appropriate policy key.  
- **Impact**: Medium

---

## 🧠 Synopsis

This script configures the Windows Installer policy to disallow users from changing install behavior or overriding admin restrictions by modifying a specific registry value.

---

## 📜 Script

```powershell
 <#
.SYNOPSIS
    This script configures the Windows Installer policy to disallow users from changing install behavior or overriding admin restrictions by modifying a specific registry value.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000310

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000310.ps1 
#>

# Ensure the script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# Define registry path and values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$valueName = "EnableUserControl"
$valueData = 0  # 0 = Disabled (prevents users from changing install options)

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    try {
        New-Item -Path $registryPath -Force | Out-Null
        Write-Host "Created registry key: $registryPath"
    } catch {
        Write-Error "Failed to create registry key: $_"
        exit 1
    }
}

# Set the registry value to disable user control over installs
try {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord
    Write-Output "Policy 'Allow user control over installs' set to 'Disabled'."
} catch {
    Write-Error "Failed to set registry value: $_"
}
 


# Set the registry value to disable user control over installs
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

Write-Output "Policy 'Allow user control over installs' set to 'Disabled'."
