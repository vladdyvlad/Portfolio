# Configure Audit Policy for User Account Management (Failure Only)

This PowerShell script ensures that **failure events** for **User Account Management** are audited according to [STIG-ID: WN10-AU-000035](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r3.audit:f21a6e6e56dc13943792d7d91e1dbe49). It uses `auditpol` to apply the setting and enforces execution as an administrator.

---

## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/1ef1f84f-a6d2-4afb-94b8-551c2d6aa676)

**After**

![Image](https://github.com/user-attachments/assets/8879de8f-37fd-408b-b30a-d4c6b99dbbb2)

> Replace with actual screenshots showing the audit policy before and after running the script.

---

## 🔒 Compliance Info

- **STIG ID**: WN10-AU-000035  
- **Description**: Audit User Account Management must be configured to capture failure events.  
- **Fix**: This script sets the correct value automatically using the built-in `auditpol` utility.  
- **Impact**: Medium

---

## 🧠 Synopsis

This script configures the Windows audit policy to **log failure events** for **User Account Management** to comply with security audit requirements.

---

## 📜 Script

```powershell

 <#
.SYNOPSIS
    This script configures the Windows audit policy to **log failure events** for **User Account Management** to comply with security audit requirements.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/erickcr1/
    GitHub          : https://github.com/erickcisneros1
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000035.ps1 
#>

# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# Set audit policy for 'User Account Management' to log failure events
$auditCategory = "Account Management"
$auditSubcategory = "User Account Management"

# Use AuditPol to enable failure auditing on the subcategory
try {
    $auditCommand = "auditpol /set /subcategory:`"$auditSubcategory`" /failure:enable"
    Invoke-Expression $auditCommand
    Write-Host "'Audit User Account Management' policy set to log Failure events."
} catch {
    Write-Error "Failed to apply audit policy: $_"
}
 
