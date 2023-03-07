## Script to compare files in a folder with filenames in a csv file
## Please adapt the $scriptPath if you want to your file monitor folder


 ##script to check whether all datasets were run through by the scripts, respectively compares a csv list with header "NamePC" with a file names contained in a folder
$Env:PATH = Get-Location
Write-Host $Env:PATH
$metafilepth = Join-Path -Path $Env:PATH -ChildPath "\metafiles\"
Write-Host $metafilepth"Databases.csv"
$P = Import-Csv $metafilepth"\Databases.csv" -Delimiter “;” #| select NamePC | ft -hide
#$P.NamePC
#$P | Get-Member
#$P | Format-Table
 
$scriptPath = "C:\Users\ZRAP\OneDrive - Hexagon\Representative data" ## changepth
$files = get-childitem $scriptPath\*.* -recurse -Include *.las,*.e57 | where-object{$_.fullname -notlike $exclude} 

#Get duplicates
#$fileNames = Get-ChildItem -Path $scriptPath -Recurse -Include *.las,*.e57
$b=$P.NamePC | select –unique
$b=$P.NamePC | select –unique
$dubs = Compare-object –referenceobject $b –differenceobject $P.NamePC
Write-Host "Duplicates found: $($dubs)"


#Get Non
#Write-Output $files.Name
$count = 0
foreach ($PointCloud in $files.Name) {
    if ($PointCloud -NotIn $P.NamePC) { 
        $count = $count + 1
        Write-Host "$($PointCloud) is not found." -ForegroundColor DarkGreen} 
    #else{
    #    Write-Host "$($PointCloud) not found." -ForegroundColor DarkRed
    #}
    }
Write-Host "$($count) datasets are not found" -BackgroundColor DarkGreen




<#
 Function Compare_lists {
    param (
        # Parameter accepts the employee id to be searched.
        [Parameter(Mandatory)]
        $PCName
    )

    # Import the contents of the employee.csv file and store it in the $employee_list variable.
    $PCNameList = Import-Csv "C:\Users\ZRAP\OneDrive - Hexagon\Representative data\TrialMetaExtraction\metafiles\Databases - Copy.csv"  -Delimiter “;”

    # Loop through all the records in the CSV
    foreach ($PC in $PCNameList) {
        #Write-Host $PC.NamePC
        # Check if the current record's employee ID is equal to the value of the EmployeeID parameter.
        if ($PC.NamePC -eq $PCName) {

            # If the EmployeeID is found, display the record on the console.
            Write-Host "$($PC.NamePC) is found."
        }
    }
}
Compare_lists -PCName $ComparePC
#>

