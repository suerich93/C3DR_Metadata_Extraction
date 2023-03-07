-- Create the database
CREATE DATABASE MetaDataExtraction;

-- Select the database
USE MetaDataExtraction;

-- Create the customers table
CREATE TABLE Metatable (
  -- dataset_id INT  AUTO_INCREMENT,
  TimeStmp INT PRIMARY KEY,
  NamePC VARCHAR(500),
  totpts INT(11),
  totdens FLOAT,
  nrFloors INT(11),
  Aream2 FLOAT,
  PCCModel VARCHAR(200)
);

-- Create the orders table
CREATE TABLE ClassTable (
  class_id INT PRIMARY KEY AUTO_INCREMENT,
  -- dataset_id INT,
  TimeStmp INT, 
  NamePC VARCHAR(500) NOT NULL,
  ClassName VARCHAR(200) NOT NULL,
  ClassNR INT(11),
  ptsclass FLOAT,
  ptsratioclass FLOAT,
  meandistdens FLOAT,
  FOREIGN KEY (TimeStmp) REFERENCES Metatable(TimeStmp)
);

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Users\\ZRAP\\OneDrive - Hexagon\\Representative data\\TrialMetaExtraction\\metafiles\\Databases.csv' REPLACE INTO TABLE `metadataextraction`.`metatable` CHARACTER SET latin1 FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES (`TimeStmp`, `NamePC`, `totpts`, `totdens`, `nrFloors`, `Aream2`, `PCCModel`);
/* 2 rows imported in 0.015 seconds. */
SHOW WARNINGS;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\Users\\ZRAP\\OneDrive - Hexagon\\Representative data\\TrialMetaExtraction\\metafiles\\DatabasesClasses.csv' REPLACE INTO TABLE `metadataextraction`.`classtable` CHARACTER SET latin1 FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES (`TimeStmp`, `NamePC`, `ClassName`, `ClassNR`, `ptsclass`, `ptsratioclass`, `meandistdens`);
/* 20 rows imported in 0.000 seconds. */
SHOW WARNINGS;