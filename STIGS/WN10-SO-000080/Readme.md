# 📜 Set Legal Notice Caption

This PowerShell script sets the legal notice caption (title) that appears on the login screen, enforcing the configuration outlined in [STIG ID: WN10-SO-000080](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r3.audit:e286f6b6b92d7ba04f425e088e2c7fcb).

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/7c9ff9ce-4f25-4b17-8612-fcb3f2f7df4c)

**After**

![Image](https://github.com/user-attachments/assets/bf02d6ad-9f3a-48b6-9020-0a500f3fdd5d)

> Use screenshots of the registry key before and after running the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-SO-000080  
- **Description**: The legal notice caption displayed at the login screen must be set to display a government notice and consent banner.  
- **Fix**: This script sets the `LegalNoticeCaption` value to "DoD Notice and Consent Banner" under the `System` policy key.  
- **Impact**: Medium

---

## 🧠 Synopsis

This script configures the Windows login screen to display a legal notice caption, specifically the "DoD Notice and Consent Banner," by modifying the registry.

---

## 📜 Script

```powershell
<#
.SYNOPSIS
    This script configures the Windows login screen to display a legal notice caption, specifically the "DoD Notice and Consent Banner," by modifying the registry.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-24
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
 
