# Enforce Password History Policy - PowerShell Script

This PowerShell script ensures that the **"Enforce password history"** setting is configured to **24** previous passwords. This helps meet compliance requirements such as [STIG-ID: WN10-AC-000020](https://www.tenable.com/audits/items/DISA_STIG_Windows_10_v2r9.audit:382a91c2e06200befc2e6cb33f3a2d76).

---

## 🔒 Compliance Info

- **STIG ID**: WN10-AC-000020
- **Description**: Enforce password history must be configured to at least 24 passwords.
- **Fix**: This script sets the correct value automatically using the built-in `secedit` utility.
- **Impact**: Medium


## 📸 Before & After

**Before**

![Image](https://github.com/user-attachments/assets/b0749f41-f3ee-452b-bc15-db9b8b606f9a)

**After**

![Image](https://github.com/user-attachments/assets/4a83bb08-c2fe-4e0a-a653-1d30b9ec7ffc)

> Replace these placeholders with actual screenshots showing the policy before and after script execution.

---

## 🧠 Synopsis

This script configures the local security policy to retain the last 24 passwords using `secedit` and a temporary configuration export.

---

## 📜 Script

```powershell
 <#
.SYNOPSIS
   This script configures the local security policy to retain the last 24 passwords using `secedit` and a temporary configuration export.

.NOTES
    Author          : Vladimir Alexis
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-05-23
    Last Modified   : 2025-05-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

    COMPLIANCE INFO
    ----------------
    STIG ID       : WN10-AC-000020
    Description   : Enforce password history must be configured to at least 24 passwords.
    Impact        : Medium
    Fix Text      : Configure the policy value for Computer Configuration ->
                    Windows Settings -> Security Settings -> Account Policies ->
                    Password Policy -> Enforce password history to 24 or more passwords remembered.

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000020.ps1 
#>


# Ensure the script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit 1
}

# Temporary security policy file
$cfgFile = "$env:TEMP\secpol.cfg"

try {
    # Export current security policy
    secedit /export /cfg $cfgFile | Out-Null

    # Read the contents
    $content = Get-Content $cfgFile

    # Modify or add the PasswordHistorySize setting
    if ($content -match "PasswordHistorySize") {
        $content = $content -replace "PasswordHistorySize\s*=\s*\d+", "PasswordHistorySize = 24"
    } else {
        $content += "`nPasswordHistorySize = 24"
    }

    # Save the updated configuration
    $content | Set-Content $cfgFile -Encoding Unicode

    # Apply the modified security policy
    secedit /configure /db secedit.sdb /cfg $cfgFile /areas SECURITYPOLICY | Out-Null

    # Confirm success
    Write-Host "'Enforce password history' successfully set to 24."
} catch {
    Write-Error "An error occurred: $_"
} finally {
    # Clean up the temporary file
    if (Test-Path $cfgFile) {
        Remove-Item $cfgFile -Force
    }
}
 
