Clear-Host
# I had to execute this as an administrator

# Check for version... Powershell Core will may come later
$PSVersion = $PSVersionTable.PSVersion
if ($PSVersion.Major -lt 5) 
{
    "Powershell Version 5.x or Powershell Core 6.0 is needed to run Posh-Git."
}

#Check Execution policy and adjust as needed.
#  Consider a method to undo or reset the policy after execution
$ExecPolicy = Get-ExecutionPolicy
if ($ExecPolicy -ne "RemoteSigned" -or $ExecPolicy -ne "Unrestricted") 
{
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
}

#Check for posh-git module.  Install if not present
$PoshGitMod = Get-Module -ListAvailable -Name posh-git
if ($PoshGitMod.Name -ne "posh-git")
{
    Install-Module posh-git -Scope AllUsers
}

Get-Module -ListAvailable -Name posh-git






#reset Execution Policy
Set-ExecutionPolicy $ExecPolicy -Scope CurrentUser -Confirm

 Get-Module -ListAvailable -Name posh-git