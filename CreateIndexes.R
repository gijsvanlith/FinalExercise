# Filename: CreateIndexes.R
# Author: Gijs van Lith
# Date: 19-11-2013
# Description: Script to create the NDVI and NDWI
# needed R version 3.0.2 

# ===================================================

# # Set Working Directory, needs to be the folder where all the scripts are located
# setwd('D:\\Workspace\\c2Scripts\\a01DownloadModisData\\RCourseHandin')

# ===================================================

# source("PackagesScript.R")

# ===================================================
# List all the available bands 

# create lists of files of the separate bands
b3files <- list.files(pattern=glob2rx("*b03.tif"),path= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005", full.names=TRUE )
b4files <- list.files(pattern=glob2rx("*b04.tif"),path= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005", full.names=TRUE )
b6files <- list.files(pattern=glob2rx("*b06.tif"),path= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005", full.names=TRUE )
id_list <- str_sub(string=b3files,start=37,end=53)
location_list <- str_sub(string=b3files, start=1, end=36)

# Create a dataframe of the bands for bookkeeping 
bands_inventory <- as.data.frame(id_list)
bands_inventory$b03 <- b3files
bands_inventory$b04 <- b4files 
bands_inventory$b06 <- b6files
bands_inventory$loclist <- location_list

# Create rasterfiles of the bands 
b3rasters <- lapply(b3files, raster) # list of raster objects
b4rasters <- lapply(b4files, raster) # list of raster objects
b6rasters <- lapply(b6files, raster) # list of raster objects

# ===================================================
# Create NDVI 


# NDVI function, also correcting for errors 
calc_ndvi <- function(b3, b4){
  dataType(b3) <- "FLT4S"
  dataType(b4) <- "FLT4S"
  result <- (b4-b3) / (b4+ b3)
  result[result > 1] <- NA
  result[result < -1] <- NA
  return(result)
}

# To speed up the process, overlay is used
overlay_ndvi <- function(ban3, ban4) {
  res <- calc_ndvi(b3=ban3,b4=ban4)
  return(res)
}

# apply the ndvi overlay function in mapply 
ndvi_rasters <- mapply(b3rasters, b4rasters, FUN=function(ban3, ban4){overlay_ndvi(ban3, ban4)}) # list of ndvi rasters

# Now save all the separate rasterfiles 
save_ndwis <- function(inrasters, idnames, loc_name) {
  idnames <- toString(idnames)
  loc_name <- toString(loc_name)
  outname <- paste(loc_name, idnames,"NDVI.tif",sep="")
  writeRaster(x=inrasters, filename=outname, overwrite=TRUE, "GTiff" )
  print("ndvi saved")
}

# Call the function for all the rasters 
mapply(FUN=save_ndwis, ndvi_rasters, bands_inventory$id_list, bands_inventory$loclist)


# ===================================================
# Create NDWI 

# NDVI function, also correcting for errors 
calc_ndwi <- function(b4, b6){
  dataType(b3) <- "FLT4S"
  dataType(b4) <- "FLT4S"
  result <- (b4-b6) / (b4+ b6)
  result[result > 1] <- NA
  result[result < -1] <- NA
  return(result)
}

# To speed up the process, overlay is used
overlay_ndwi <- function(ban4, ban6) {
  res <- calc_ndwi(b4=ban4,b6=ban6)
  return(res)
}

# apply the ndvi overlay function in mapply 
ndwi_rasters <- mapply(b4rasters, b6rasters, FUN=function(ban4, ban6){overlay_ndwi(ban4, ban6)}) # list of ndwi rasters

# Now save all the separate rasterfiles 
save_ndwis <- function(inrasters, idnames, loc_name) {
  idnames <- toString(idnames)
  loc_name <- toString(loc_name)
  outname <- paste(loc_name, idnames,"NDWI.tif",sep="")
  writeRaster(x=inrasters, filename=outname, overwrite=TRUE, "GTiff" )
  print("ndwi saved")
}

# Call the function for all the rasters 
mapply(FUN=save_ndwis, ndwi_rasters, bands_inventory$id_list, bands_inventory$loclist)


