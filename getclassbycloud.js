/// <reference path="C:\Program Files\Leica Geosystems\Cyclone 3DR\Script\JsDoc\Reshaper.d.ts"/>
//Change variables:
var screenshotpath = "C:/Users/ZRAP/OneDrive - Hexagon/Representative data/TrialMetaExtraction/screenshots/"  //changepth
var path = new String("C:/Users/ZRAP/OneDrive - Hexagon/Representative data/TrialMetaExtraction/metafiles/Databases.csv");  //changepth
//var myCloud='C:/PowerAutomate_Extraction/PA_REDUCED.e57'; 

//Import Clouds
var res = SSurveyingFormat.ImportCloud(myCloud,0);
if(res.ErrorCode != 0)
   throw new Error("An error occurred during the import.");

//var mergedCloud = SCloud.Merge(res.CloudTbl).Cloud;

//total nr of points
var ttlpts = 0
for(var n=0; n<res.CloudTbl.length; n++)
    {var cur = res.CloudTbl[n].GetNumber();
    ttlpts += cur;
    }

//point density
var dens = 0
for(var nn=0; nn<res.CloudTbl.length; nn++)
    {var curr = res.CloudTbl[nn].GetMeanDistance();
    dens += curr
    }
dens = dens/res.CloudTbl.length;


//see avail model names
//print(SCloud.GetClassificationModels());


//classify PC
var clcloud = SCloud.Classify(res.CloudTbl,"PCC_INDCS_GEN 000123_B");

//explode clouds
var arrayname_nr = [];
for(var ii=0; ii<clcloud.CloudTbl.length; ii++)
{
    var curCloud = clcloud.CloudTbl[ii];
    var expcl = curCloud.ExplodeByClass();
    if(expcl.ErrorCode == 0)
        {
        print("done exploding")
        }
}


//array of class nr & name && nr of points && meandistance
var arrayLength = expcl.ClassTbl.length;
var floorID = 122;//
var floorCloud = null;//

for (var i = 0; i < arrayLength; i++) {
    var currentId = expcl.ClassTbl[i];
    var currentCloud = expcl.CloudTbl[i];

    var classnme_nr = SCloud.GetClassName(currentId).Name + "_" + currentId + "_" + currentCloud.GetNumber() + "_" + (currentCloud.GetNumber()/ttlpts) + "_" + currentCloud.GetMeanDistance();
    arrayname_nr.push(classnme_nr);
      if(currentId == floorID)
    {
        floorCloud = currentCloud;
    }
}
print(arrayname_nr);


// Add all your point clouds in your document
for(i = 0; i < expcl.CloudTbl.length; i++) 
   expcl.CloudTbl[i].AddToDoc();
if(!currentCloud)
{
    throw new Error("No floor Class detected!");
}

//works with big floor patches > not vertically differentiated; add noise reduction and colorgradient
var nr_floors = [];
var nonoise_inputs = floorCloud.NoiseReductionSplit(80).GoodCloud;

//Explode Cloud with noise reduction to get separated areas
var floorssep = nonoise_inputs.Explode(2,100,5);//CloudNoNoise[0]
var floorarea = 0
var array_surfacearea = [];
for(iiii = 0; iiii < floorssep.CloudTbl.length; iiii++){
    floorssep.CloudTbl[iiii].AddToDoc()
    var flrnr = iiii.toString()
    floorssep.CloudTbl[iiii].SetName("Floor"+flrnr)
    var floormesh = floorssep.CloudTbl[iiii].ScanToMesh("Low", false,true);
    if(floormesh.ErrorCode == 0)
    {
    floormesh.Poly.AddToDoc();
    print("done meshing" + flrnr);
    var floorsurf = floormesh.Poly.GetSurface();
    floorarea += floorsurf.Surface
    }
}
array_surfacearea.push(floorarea);
nr_floors.push(floorssep.CloudTbl.length);
print("The nr of floors count: "+ floorssep.CloudTbl.length);
print("done separating");
print("The area of the floors account: " + array_surfacearea)


//remove all from doc
var allcld = SCloud.All(1);
for(var ac=0; ac<allcld.length; ac++)
    {
        allcld[ac].RemoveFromDoc();
    }

//add to doc for screenshots
for(var m=0; m<res.CloudTbl.length; m++)
    {
    res.CloudTbl[m].SetCloudRepresentation(SCloud.CLOUD_COLORED)
    res.CloudTbl[m].AddToDoc();
    }
//take screenshot from 3 sides
//parameters
var hght = 400;
var wdt = 600;
var bkgtp = 0;
var magnif = 0;
var imagesfolder = mkdir(screenshotpath);
SetViewDir(AXIS_X); 
ZoomOn(res.CloudTbl,1);
CreatePicture(screenshotpath + myCloud.split("/").pop() +"1.png",hght,wdt,bkgtp,magnif);  
SetViewDir(AXIS_Y);
ZoomOn(res.CloudTbl,1);
CreatePicture(screenshotpath + myCloud.split("/").pop() +"2.png",hght,wdt,bkgtp,magnif);  
SetViewDir(AXIS_Z); 
ZoomOn(res.CloudTbl,1);
CreatePicture(screenshotpath + myCloud.split("/").pop() +"3.png",hght,wdt,bkgtp,magnif);  

//Name of PC
var nmePC = myCloud.split("/").pop();

//define (header) && content
//var header = new String("Name PC;Classes;Nr_Floors;Area;\n"
var data = [];
data.push(nmePC);
data.push(arrayname_nr.join(","));
data.push(ttlpts);
data.push(dens);
data.push(String(floorssep.CloudTbl.length));
data.push(String(array_surfacearea.join()));


//open file, write last line in csv
var db = SFile.New(path);
var isOpen = db.Open(SFile.Append);
var delimiter=";";
if(isOpen)
{
  if(db.AtEnd()){
    print(db.AtEnd());
    db.Write("\n");
    db.Write(data.join(delimiter));
  }
}
