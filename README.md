# <

###Description
## The script includes a subscript called startjobs.ps1 and getclassbycloud.js. The script monitors the folder which it is contained in and creates a metafiles folder and a screenshots folder if it does not exist. 
## It runs C3DR in the background and extracts metadata: Name PC;Classnr_Classname_ptsperclass_ptsratioclass_meandistDensity;Totpts;TotDensity;Nr_Floors;Area;
## It then adds the metadata to a csv and deletes the job created in the powershell and the added and monitored las or e57 file. 
## Screenshots from x, y, z side are taken and named accordingly to filename. 
## For questions: raphael.zuercher-ext@hexagon.com


### Requirements
- Cyclone 3DR
- Powershell (Windows)

