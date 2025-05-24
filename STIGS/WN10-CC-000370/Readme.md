# 🚫 Disable Convenience PIN Sign-In

This PowerShell script disables the convenience PIN sign-in for Windows, enforcing the configuration outlined in [STIG ID: WN10-CC-000370](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r5.audit:ca962dcadc1f0678ac7aa9dc255257ed).

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/338f58f3-9ce5-4fef-a7f0-be130609d79a)

**After**

![Image](https://github.com/user-attachments/assets/1249b5c4-4362-43ac-9a37-20ee7328c999)

> Use screenshots of the registry key before and after running the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-CC-000370  
- **Description**: Convenience PIN sign-in must be disabled to ensure that users cannot bypass stronger authentication methods.  
- **Fix**: This script sets the registry value `AllowDomainPINLogon` to `0` under the appropriate policy key.  
- **Impact**: Medium

---

## 🧠 Synopsis

This script disables the use of a PIN for logging into a domain, enforcing more secure login methods through registry modifications.

---

## 📜 Script

```powershell
<#
.SYNOPSIS
    This script disables the use of a PIN for logging into a domain, enforcing more secure login methods through registry modifications.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000370.ps1 
#>

# Define the registry path and values
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$regName = "AllowDomainPINLogon"
$regValue = 0

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the registry setting
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null

Write-Host "'Turn on convenience PIN sign-in' policy set to 'Disabled' successfully."
