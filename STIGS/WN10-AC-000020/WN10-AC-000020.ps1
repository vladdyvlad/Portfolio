 <#
.SYNOPSIS
   This script configures the local security policy to retain the last 24 passwords using `secedit` and a temporary configuration export.

.NOTES
    Author          : Vladimir Alexis
    LinkedIn        : https://www.linkedin.com/in/valexis/
    GitHub          : https://github.com/vladdyvlad
    Date Created    : 2025-04-27
    Last Modified   : 2025-04-27
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
 
