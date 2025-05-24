# ⏲️ Set Interactive Logon Inactivity Timeout

This PowerShell script sets the inactivity timeout for interactive logons, enforcing the configuration outlined in [STIG ID: WN10-SO-000070](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r1.audit:ad29a5ab9d36d93d7ef6089073c5318c).

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/f951c0c1-910d-4646-9553-5ccc89a7ce6a)

**After**

![Image](https://github.com/user-attachments/assets/75b016ba-76ed-40d6-b92c-d6e00eca5917)

> Use screenshots of the registry key before and after running the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-SO-000070  
- **Description**: The interactive logon inactivity timeout must be configured to automatically log off users after a specified period of inactivity.  
- **Fix**: This script sets the `InactiveThreshold` value under the `Lsa` key and `InactivityTimeoutSecs` under the `Winlogon` key to 900 seconds (15 minutes).  
- **Impact**: Medium

---

## 🧠 Synopsis

This script sets the inactivity timeout for interactive logons to 900 seconds (15 minutes) by modifying the Windows registry under both `Lsa` and `Winlogon` paths.

---

## 📜 Script

```powershell
<#
.SYNOPSIS
   This script sets the inactivity timeout for interactive logons to 900 seconds (15 minutes) by modifying the Windows registry under both `Lsa` and `Winlogon` paths.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-24
    Last Modified   : 2025-05-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000070.ps1 
#>


 # Define primary registry path and value
$lsaPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$lsaValueName = "InactiveThreshold"
$desiredTimeout = 900

# Ensure the key exists
if (-not (Test-Path $lsaPath)) {
    New-Item -Path $lsaPath -Force | Out-Null
}

# Set the inactivity timeout for LSA
Set-ItemProperty -Path $lsaPath -Name $lsaValueName -Value $desiredTimeout

# Define Winlogon policy path and value
$winlogonPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$winlogonValue = "InactivityTimeoutSecs"

# Ensure the key exists
if (-not (Test-Path $winlogonPath)) {
    New-Item -Path $winlogonPath -Force | Out-Null
}

# Set the inactivity timeout for Winlogon
Set-ItemProperty -Path $winlogonPath -Name $winlogonValue -Value $desiredTimeout

Write-Host "'Interactive logon: Machine inactivity limit' successfully set to $desiredTimeout seconds (15 minutes)."
 
