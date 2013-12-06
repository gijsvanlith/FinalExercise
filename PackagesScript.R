# Filename: PackageScript.R
# Author: Gijs van Lith
# Date: 19-11-2013
# Description: This script downloads, installs, and turns on all the needed packages
# needed R version 3.0.2 

# ===================================================

# load the necessary packages
install.packages("ptw", dependencies=TRUE)
install.packages("mapdata", dependencies=TRUE)
install.packages("rgdal",dependencies=TRUE) 
install.packages("MODIS", repos="http://R-Forge.R-project.org", dependencies=TRUE)
install.packages("gdalUtils", repos="http://R-Forge.R-project.org")
install.packages("stringr",dependencies=TRUE) 
install.packages("spatial.tools",dependencies=TRUE) 
install.packages("ggplot2",dependencies=TRUE) 
install.packages("rasterVis",dependencies=TRUE) 
install.packages("raster",dependencies=TRUE) 


library(MODIS)
library(ptw)
library(mapdata)
library(rgdal)
library(gdalUtils)
library(stringr)
library(spatial.tools)
library(ggplot2)
library(rasterVis)
library(raster)

# # set modis settings about where to store etc.  
# # gdalPath <- "C:\\Program Files (x86)\\Quantum GIS Lisboa\\bin"
# 
# MODISoptions(localArcPath="D:/MODIS_ARC/MODIS", outDirPath = "D:/MODIS_ARC/PROCESSED",
#              pixelSize=500,gdalPath =gdalPath, systemwide = TRUE,checkPackages=TRUE)

# set/check GDAL installation 
gdal_setInstallation()