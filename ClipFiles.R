# Filename: ClipFiles
# Author: Gijs van Lith
# Date: 19-11-2013
# Description: This script clips the GeoTiffs Modis bands before indices are calculated
#               This is used to be able to reproduce the script.   
# needed R version 3.0.2 

# ===================================================

# Load a rasterfile, and create an extent
r <- raster(x= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005/MODA2000153h22v01b03.tif")

# plot(r)
# e <- drawExtent(show=TRUE)
# plot(r, ext=e, legend=FALSE)
# clipbox <- drawExtent(show=TRUE)
# clipbox <- extent(x=c(-269486.3 ,145973.6 ,7808391 ,8033079))
#   plot(clipbox, add=TRUE)

# list all the rasters in the mainfile
allfiles <- list.files(pattern=glob2rx("*.tif"),path= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005", full.names=TRUE, recursive=FALSE)

# Function to crop the rasters, and save them
cropimages <- function(in_name) {
  clipbox <- extent(x=c(-269486.3 ,145973.6 ,7808391 ,8033079))
  in_name <- toString(in_name)
  print(in_name)
  rast <- raster(in_name)
  cropped <- crop(x=rast, y=clipbox)
  writeRaster(x=cropped, filename=in_name, overwrite=TRUE)
}

mapply(FUN=cropimages, allfiles)

