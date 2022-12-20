### Description
- The script includes a subscript called startjobs.ps1 and getclassbycloud.js. The script monitors the folder which it is contained in and creates a metafiles folder and a screenshots folder if it does not exist. 
- It runs C3DR in the background and extracts metadata: **Name PC;Classnr_Classname_ptsperclass_ptsratioclass_meandistDensity;Totpts;TotDensity;Nr_Floors;Area; **
- It runs one file by one.
- It then adds the metadata to a csv and deletes the job created in the powershell and the added and monitored **las or e57** file. 
- **Screenshots** from x, y, z side are taken and named accordingly to filename. 
- To start the monitoring and extraction, please right click and "run with Powershell". To stop it just close it. The metadata extraction is triggered by adding a las or e57 file to the main folder.
- If C3DR is not on default path, please adapt
- Default model: IndoorCS - to change in getclassbycloud.js
- For questions: raphael.zuercher-ext@hexagon.com

### Requirements
- Cyclone 3DR & valid license
- Powershell (Windows)

