## The script includes a subscript called startjobs.ps1 and getclassbycloud.js. The script monitors the folder which it is contained in and creates a metafiles folder and a screenshots folder if it does not exist. 
## It runs C3DR in the background and extracts metadata: Name PC;Classnr_Classname_ptsperclass_ptsratioclass_meandistDensity;Totpts;TotDensity;Nr_Floors;Area;
## It then adds the metadata to a csv and deletes the job created in the powershell and the added and monitored las or e57 file. 
## Screenshots from x, y, z side are taken and named accordingly to filename. 
## For questions: raphael.zuercher-ext@hexagon.com


    $Env:PATH = Get-Location
    Write-Host $Env:PATH
    $metafilepth = Join-Path -Path $Env:PATH -ChildPath "\metafiles\"
        if (Test-Path $metafilepth) {
            Write-Host "Folder" + $metafilepth + "Exists"
            # Perform Delete file from folder operation
        }
        else
        {
            #PowerShell Create directory if not exists
            New-Item $metafilepth -ItemType Directory
            Write-Host "Folder" + $metafilepth "Created successfully"
        }
    $Databasesfilepth = $metafilepth
    $DBname = "\Databases.csv"
    if (!(Test-Path ($Databasesfilepth+$DBname))){
       New-Item -itemType File -Path $metafilepth -Name $DBname -value "Name PC;Classnr_Class_ptsclass_ptsratioclass_meandistDensity;Totpts;TotDensity;Nr_Floors;Area;"
       Write-Host "Created new file and text content added"
    } 
    else {
      Write-Host "File already exists"
    }
### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    ##e57 change
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $Env:PATH   ##changepth
    $watcher.Filter = "*.e57"
    $watcher.IncludeSubdirectories = $false
    $watcher.EnableRaisingEvents = $true
    
    ##las change
    $watcherlas = New-Object System.IO.FileSystemWatcher
    $watcherlas.Path = $Env:PATH   ##changepth
    $watcherlas.Filter = "*.las"
    $watcherlas.IncludeSubdirectories = $false
    $watcherlas.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
		###split path to get new file name (las/e57)
		Convert-Path $path
        #C3dr path change
        $C3drpth = $path.Replace('\','/')
		$cloudname = Split-Path -Path ($metafilepth+"*.e57") -Leaf -Resolve   ##changepth
                $logline = "$(Get-Date), $changeType, $path, $cloudname, $C3drpth"
                $logline_Jobs =   '--script="./getclassbycloud.js"' +'  --scriptOutput="./metafiles/Output.log"'+ '  --silent'+   '  --scriptParam="var myCloud='+"`'" + $C3drpth + "`';`"   "  ##changepth
        ##jobs listing && logs creation        
                Add-content .\metafiles\logs.txt -value $logline  ##changepth
                Add-content .\metafiles\jobs.txt -value $logline_Jobs  ##changepth
### run C3DR for metadataextraction
         .\startjobs.ps1 ##changepth
              }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -Action $action
    Register-ObjectEvent $watcherlas "Created" -Action $action ##las change
    #Register-ObjectEvent $watcher "Changed" -Action $action
    #Register-ObjectEvent $watcher "Deleted" -Action $action
    #Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}

