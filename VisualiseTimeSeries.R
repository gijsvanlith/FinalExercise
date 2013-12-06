# Filename: VisualiseTimeSeries
# Author: Gijs van Lith
# Date: 05-12-2013
# Description: This script visualises the time series of NDVI vs NDWI
# needed R version 3.0.2 

# ===================================================
# source("PackagesScript.R")

# List all images 
ndvi_files <- list.files(pattern=glob2rx("*NDVI.tif"),path= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005", full.names=TRUE, recursive=FALSE)
ndwi_files <- list.files(pattern=glob2rx("*NDWI.tif"),path= "D:/MODIS_ARC/MODISMODIS/MOD09A1.005", full.names=TRUE, recursive=FALSE)

# Stack all images per NDVI / NDWI
ndvi_stack <- stack(x=ndvi_files)
ndwi_stack <- stack(x=ndwi_files)

# Create image info dataframe
sceneinfo <- as.data.frame(ndvi_files)
sceneinfo$ndwi_files <- as.data.frame(ndwi_files)
sceneinfo$Scene_ID_NDVI <- names(ndvi_stack)
sceneinfo$Scene_ID_NDWI <- names(ndwi_stack)
sceneinfo$Scene_ID <- str_sub(string=sceneinfo$Scene_ID_NDWI, start=1,end=17)
sceneinfo$Dates <- str_sub(string=sceneinfo$Scene_ID, start=5, end=11)


# Create mean values ndvi ndwi
# create mean rasters 
meanNDVI <- calc(x=ndvi_stack, fun=mean, na.rm = TRUE) 
meanNDWI <- calc(x=ndwi_stack, fun=mean, na.rm = TRUE) 

# Visualise the time series

# Create means per layer 
win <- extent(ndvi_stack)
ndvi_means <- extract(x= ndvi_stack, y=win, fun=mean)
ndwi_means <- extract(x= ndwi_stack, y=win, fun=mean)

# Add them to the dataframe 
sceneinfo$ndvi_mean <- as.numeric(ndvi_means)
sceneinfo$ndwi_mean <- as.numeric(ndwi_means)

  
d1 <- data.frame(  date = sceneinfo$Dates,  index= sceneinfo$ndvi_mean,   name = "NDVI")
d2 <- data.frame(  date = sceneinfo$Dates,  index= sceneinfo$ndwi_mean,   name = "NDWI")

# add data.frame d2 to d1
tss <- rbind(d1, d2)

# Plot the time series using ggplot 
ggplot(data = tss, aes(x = date, y = index)) +  geom_point() +  geom_line() +  facet_wrap(~ name, nrow = 2) +  theme_bw()
ggplot(data = tss, aes(x = date, y = index, colour = name)) +  geom_point() + geom_line()





