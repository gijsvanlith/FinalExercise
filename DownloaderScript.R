# Filename: DownloaderScript
# Author: Gijs van Lith
# Date: 29-11-2013
# Description: Script to download the needed Modis images
# needed R version 3.0.2 


# source(file="PackagesScript.R")

# ===================================================
# Download all needed hdf files. 


# Script to download only a certain range of months over multiple years, 
# input in the form of DD.MM.YYYY. For instance from 01.05.2000 to 01.08.2004 will download 
# all the available images of the needed Modis product of the months May to August, of the years 2000-2004 

createmultiyears  <- function( dates, product = NULL, collection = NULL,h = C(), v = c(), localArcPath=NULL,outDirPath = NULL ) {
    startdate <- dates[1]
    enddate <- dates[2]
    splitstart <- strsplit(startdate, '[.]')
    splitend <- strsplit(enddate, '[.]')
    year <- as.numeric(splitstart[[1]][3])
    startmonth <- splitstart[[1]][2]
    endmonth <- splitend[[1]][2]
    startday <- splitstart[[1]][1]
    endday <- splitend[[1]][1]
    endyearnum <- as.numeric(splitend[[1]][3])
    endyear <- splitend[[1]][3]
    print ("start download")
    while (year <= endyearnum){
      currentyear <- as.character(year)
      fromdate <- paste(currentyear,startmonth,startday, sep = '.')
      todate <- paste(currentyear,endmonth, endday, sep = '.')
      print (paste("start download year",currentyear))
      print(c(fromdate, todate, product, collection, h,v,localArcPath))
      getHdf(product = product, begin= fromdate, end=todate, tileH=h, tileV=v, 
             collection = collection, quiet=FALSE, wait=0.5, checkIntegrity=FALSE, 
             localArcPath = localArcPath, outDirPath = outDirPath)   
      print (paste(currentyear,"downloaded"))
      year <- year +1
    }
  }

# Call the function 
# neededdates = c('01.05.2000','01.10.2000')
# createmultiyears(dates = neededdates, product = "MOD09A1", collection = 005,
#                  h = 23, v =1, localArcPath= "D:\\MODIS_ARC\\MODIS",
#                  outDirPath ="D:\\MODIS_ARC\\PROCESSED"  )
  


