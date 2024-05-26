#For more information refer to the Wiki: https://github.com/RichWyble/Scripts/wiki/Move_files_created_by_SSMS_Script_generator_to_object_type_folders.ps1

Clear-Host

# Set the source.  New folders will be created based on object type.

$sourceFolder = "C:\Repo\RPWData\Revo\RNR_db"

#change operating folder
set-location -Path $sourceFolder

# Get all the files in the source folder
$fileList = Get-ChildItem -Path $sourceFolder -File

# Loop through each file
foreach ($file in $fileList) {
    # Extract schema, object name, and object type from the file name
    $schema = ""
    $objectName = ""
    $objectType = ""
    $extension = ""
    $NewFileName = 
    $fileName = $file.Name
    $parts = $fileName -split '\.'
    
    #The number of parts of the file name matters.  
    # it would be more elagant to reverse the broken file name
    # and have 0 always be the extension, 1 be the object type, 2 be the object name 
    # and 3, if it exists, be the schema name.

    if ($parts.Length.Equals(4)) {
        $schema = $parts[0]
        $objectName = $parts[1]
        $objectType = $parts[2]
        $extension = $parts[3]
        $NewFileName = "$schema.$objectName.$extension"

    }
    if ($parts.Length.Equals(3)) {
        $objectName = $parts[0]
        $objectType = $parts[1]
        $extension = $parts[2]
        $NewFileName = "$objectName.$extension"

    } 
    
    # Check if directory (object type) exists, if not
    #  create a new directory in the current folder
    if (-not (Test-Path -Path $objectType -PathType Container)) {
        New-Item $objectType -ItemType Directory
        Write-Output "Directory created: $objectType"
    } 
    $destinationFolderPath = Join-Path -Path $sourceFolder -ChildPath "$objectType\$NewFileName"

    Move-Item -Path $fileName -Destination $destinationFolderPath -Force

}
