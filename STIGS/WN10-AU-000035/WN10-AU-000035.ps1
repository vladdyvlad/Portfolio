 <#
.SYNOPSIS
    This script configures the Windows audit policy to **log failure events** for **User Account Management** to comply with security audit requirements.

.NOTES
    Author          : Vladimir
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
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
 
