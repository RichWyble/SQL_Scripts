####In this script, replace 'MY_SERVER_NAME' with your server name and 'MY_DATABASE_NAME' with your database name. This script will generate a SQL script for each table in the specified database and write it to the file C:\output\output.sql1.
####
####Please note that you need to have the SQL Server Management Studio (SSMS) installed on the machine where you run this script, as it relies on the SMO libraries that come with SSMS1.



# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMOExtended') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SQLWMIManagement') | out-null

# Get the SMO server object
$srv = New-Object ('Microsoft.SqlServer.Management.Smo.Server') 'MY_SERVER_NAME'

# Set the scripting options
$scriptr = new-object ('Microsoft.SqlServer.Management.Smo.Scripter') ($srv)
$scriptr.Options.ScriptDrops = $false
$scriptr.Options.WithDependencies = $true

# Output script to file
$scriptr.Options.ToFileOnly = $true
$scriptr.Options.FileName = 'C:\output\output.sql'

# Enumerate the tables on the database and script each one
$db = $srv.Databases['MY_DATABASE_NAME']
foreach ($table in $db.Tables) {
    # Exclude system tables
    if ($table.IsSystemObject -eq $false) {
        $scriptr.EnumScript($table)
    }
}


