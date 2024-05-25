Clear-Host

Import-Module posh-git
# Need to execute "Install-Module PSColor" as an administrator

cd C:\Repo\RPWData\Scripts
# will see
# path [branch  +Added ~Modified -Removed !Conflicted
#   for more details reference:
#     https://github.com/dahlbyk/posh-git?tab=readme-ov-file#git-status-summary-information
# Run git status and capture the output
#$GitStatus = git status

$Repo = Split-Path -Leaf (git remote get-url origin)
$UnstagedFiles = git ls-files --others
$UnstagedFiles
$UnstagedFiles.count

#.Split([Environment]::NewLine)
$uf = $UnstagedFiles#.Split(",")# -split ","
$StagedFiles = git diff --name-only --staged

write-host "Git Status for $Repo"
Write-Host
Write-Host "Files Not Under Source Control" -ForegroundColor Red
foreach ($uf in $UnstagedFiles)
{
    Write-Host "  * $uf" -ForegroundColor Red
}
Write-Host
Write-Host "     (use 'git add .' to include all uncommited files be committed)" -ForegroundColor black -BackgroundColor Gray
foreach ($uf in $UnstagedFiles)
{
    Write-Host "     (use 'git add $uf' to include $uf in commit.)" -ForegroundColor black -BackgroundColor Gray
}

Write-Host
Write-Host "Staged Files (Under source control, but with uncommitrd changes)" -ForegroundColor Cyan
Write-Host $StagedFiles -ForegroundColor Cyan
Write-Host "     (use 'git restore --staged <file>...' to unstage)" -ForegroundColor black -BackgroundColor Gray

                                                                                            