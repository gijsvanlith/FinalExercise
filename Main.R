# Filename: Main
# Author: Gijs van Lith
# Date: 19-11-2013
# Description: Main script to run all other scripts
# needed R version 3.0.2 

# ===================================================

# Set Working Directory, needs to be the folder where all the scripts are located
# setwd('D:\\Workspace\\c2Scripts\\a01DownloadModisData\\RCourseHandin')

# Load needed libraries, and set the gdal location
source("PackagesScript.R")

# ===================================================
# Downloader script for MRT tool

# Download the images
source('DownloaderScript.R') 

neededdates = c('01.06.2000','01.10.2000')
createmultiyears(dates = neededdates, product = "MOD09A1", collection = 005,
                 h = 22, v =1, localArcPath= "D:\\MODIS_ARC\\MODIS",
                 outDirPath ="D:\\MODIS_ARC\\PROCESSED")


# change the bands in the hdf files in the mainfolder into reprojected Geotiffs 

source('TransformImages.R') 

# run it, variable is the main folder location of all the images 
create_subset("D:\\MODIS_ARC\\MODISMODIS\\MOD09A1.005\\")


# # Clip the images to save space for reprodcability
# 
# source('ClipFiles.R')


# Create the NDWI and NDVI Indices

source('CreateIndexes.R') 


# Visualise time series
source('VisualiseTimeSeries.R')





