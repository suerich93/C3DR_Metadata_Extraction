$files = ".\metafiles\jobs.txt"  

## read jobs and run C3DR for analysis; remove job from jobs.txt if complete; asynchrononous job (onebyone)
foreach($line in [System.IO.File]::ReadLines($files))
{
    Write-Output $line 
    #run C3DR script and generate output
    Start-Process -FilePath "C:\Program Files\Leica Geosystems\Cyclone 3DR\3DR.exe" -ArgumentList $line -Wait -PassThru  ##changepth
    #remove file
    $scriptparampath = ($line -split '  ')[3]   #check --silence param > nr to 3
    $wholepath = ($scriptparampath -split '=')[2]
    $pathremove = ($wholepath -split ';')[0]
    $pthrem = $pathremove.Replace('/','\')
    $pthrem = $pthrem.Replace("`'","")
    Write-Host ("removing: " + $pthrem) -ForegroundColor Green
    Remove-Item -Path $pthrem
    $removejobsarray = @()
    $removejobsarray += $line
    #do{$line} until ($line -eq $null)
    #Start-Process $line
}
Write-Host $removejobsarray -ForegroundColor Red
#remove item from jobs list
Foreach ($i in $removejobsarray)
{
    Set-Content -Path $files -Value (get-content -Path $files | Select-String  $i)
    Write-Host "Removing $line" -ForegroundColor Green

}
