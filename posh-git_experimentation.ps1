Clear-Host

#Add the appropriate Repo location
$RepoLocation = "C:\Repo\RPWData\Scripts"

#Uncomment if this module is actually needed
Import-Module posh-git

cd $RepoLocation

#reset values
$GitStatus = $null
$Repo = $null
$UnstagedFiles = $null
$StagedFiles = $null


# will see
# path [branch  +Added ~Modified -Removed !Conflicted
#   for more details reference:
#     https://github.com/dahlbyk/posh-git?tab=readme-ov-file#git-status-summary-information
# Run git status and capture the output
$GitStatus = Get-GitStatus

$Repo = $GitStatus.RepoName
$UnstagedFiles = $GitStatus.Working
$StagedFiles = $GitStatus.Index
$FilesWithStagedAndUnstagedChanges = Compare-Object $UnstagedFiles $StagedFiles -IncludeEqual -ExcludeDifferent | ForEach-Object { $_.InputObject }

write-host "Git Status for $Repo Repo"
Write-Host

if($FilesWithStagedAndUnstagedChanges.Count -gt 0)
{
    Write-Host "The following files have both staged and unstaged changes" -ForegroundColor White -BackgroundColor Red
    foreach ($f in $FilesWithStagedAndUnstagedChanges)
    {
        Write-Host "  * $f" -ForegroundColor White -BackgroundColor Red
    }
    Write-Host
} 
 

if ($UnstagedFiles.Count -gt 0) {
Write-Host "Files with unstaged changes" -ForegroundColor Red
    foreach ($uf in $UnstagedFiles)
    {
        Write-Host "  * $uf" -ForegroundColor Red
    }
    Write-Host
    Write-Host " Copy the commands below to stage specific files or 'git add .' for all files" -ForegroundColor Green
    Write-Host "     git add ."  -ForegroundColor White -BackgroundColor Black
    foreach ($uf in $UnstagedFiles)
    {
        Write-Host "     git add $uf"  -ForegroundColor White -BackgroundColor Black
    }
    Write-Host " Use these commands below to discard changes in working directory" -ForegroundColor Green
    foreach ($uf in $UnstagedFiles)
    {
        Write-Host "     git restore $uf"  -ForegroundColor White -BackgroundColor Black
    }

} else 
{
    Write-Host "All local files under source control" -ForegroundColor Red
    
}

Write-Host

if($StagedFiles.Count -gt 0)
{
    Write-Host "Staged Files (Under source control, but with uncommited changes)" -ForegroundColor Cyan
    foreach ($sf in $StagedFiles)
    {
        Write-Host "  * $sf" -ForegroundColor Cyan
    }
    Write-Host
    Write-Host " Copy the commands below to remove specific files from staging" -ForegroundColor Green
    foreach ($sf in $StagedFiles)
    {
    Write-Host "     git restore --staged $sf" -ForegroundColor White -BackgroundColor Black
    }

} else
{
    Write-Host "No staged files for commit" -ForegroundColor Cyan

}
Write-Host
Write-Host

 

