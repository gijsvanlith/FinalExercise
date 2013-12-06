# Filename: DownloaderScript
# Author: Gijs van Lith
# Date: 29-11-2013
# Description: This script transforms the HDF images to GeoTifs, it also selects the needed bands
# needed R version 3.0.2 

# ===================================================
# function for a single hdf file. Needed bands are selected and transformed 
# to a geotiff with a new projection. Files are stored in the same directory as where they came from

generate_geotifs<- function(hdf_filename, main_d) {
  # get subdatasets   
  sds <- get_subdatasets(hdf_filename)
  for (i in 1:length(sds)){
    # Select bands needed 
    if(grepl(x=sds[i], pattern='b03', fixed=TRUE)){
      b3 <- (sds[i])
    } 
    else if(grepl(x=sds[i], pattern='b04',fixed=TRUE)){
      b4 <- (sds[i])
    }
    else if(grepl(x=sds[i], pattern='b06',fixed=TRUE)){
      b6 <- (sds[i])
    }
    else if(grepl(x=sds[i], pattern='qc_500m',fixed=TRUE)){
      q1 <- (sds[i])
    }
    else if(grepl(x=sds[i], pattern='state_500m',fixed=TRUE)){
      q2 <- (sds[i])
    }
  }
  
  # select image filename 
  #   dst_name <- str_sub(string=sds[i],start=19,end=106)
  dst_loc <- main_d
  
  dst_name1 <- str_sub(string=sds[1],start=66,end=69)
  dst_name2 <- str_sub(string=sds[1],start=75,end=82)
  dst_name3 <- str_sub(string=sds[1],start=84,end=89)
  
  dst_b3 <- paste(dst_loc,"/", dst_name1, dst_name2, dst_name3,"b03",'.tif',sep= "" )
  dst_b4 <- paste(dst_loc,"/", dst_name1, dst_name2, dst_name3,"b04",'.tif',sep= "" )
  dst_b6 <- paste(dst_loc,"/", dst_name1, dst_name2, dst_name3,"b06",'.tif',sep= "" )
  dst_q1 <- paste(dst_loc,"/", dst_name1, dst_name2, dst_name3,"qc500m",'.tif',sep= "" )
  dst_q2 <- paste(dst_loc,"/", dst_name1, dst_name2, dst_name3,"state500m",'.tif',sep= "")
  
  
  # transform to GeoTiff and reproject 
  ras_b3 <- gdalwarp(srcfile=b3, dstfile=dst_b3, t_srs='+proj=utm +zone=55 +ellps=WGS84 +datum=WGS84 +units=m +no_defs', overwrite=TRUE)
  print("Band 3 Created")
  ras_b4 <- gdalwarp(srcfile=b4, dstfile=dst_b4, t_srs='+proj=utm +zone=55 +ellps=WGS84 +datum=WGS84 +units=m +no_defs',overwrite=TRUE)
  print("Band 4 Created")
  ras_b6 <- gdalwarp(srcfile=b6, dstfile=dst_b6, t_srs='+proj=utm +zone=55 +ellps=WGS84 +datum=WGS84 +units=m +no_defs',overwrite=TRUE)
  print("Band 6 Created")
  ras_q1 <- gdalwarp(srcfile=q1, dstfile=dst_q1, t_srs='+proj=utm +zone=55 +ellps=WGS84 +datum=WGS84 +units=m +no_defs',overwrite=TRUE)
  print("Quality flag image 1 Created")
  ras_q2 <- gdalwarp(srcfile=q2, dstfile=dst_q2, t_srs='+proj=utm +zone=55 +ellps=WGS84 +datum=WGS84 +units=m +no_defs',overwrite=TRUE)
  print("Quality flag image 2 Created")
} 

# main function which changes the bands in the hdf files in the mainfolder into reprojected Geotiffs 

create_subset <- function(main_directory) {
  # list all files ending with .hdf in the main directory. 
  
  hdf_loclist <- list.files(path= main_directory ,pattern='(.*)(hdf)' ,all.files=FALSE, full.names=TRUE, recursive=TRUE)
  hdf_loclist <- hdf_loclist[str_sub(string=hdf_loclist, -4, -1)=='.hdf']
  out <-lapply(FUN=generate_geotifs, X=hdf_loclist, main_d = main_directory)
}

# # # Run the function: 
# create_subset("D:\\MODIS_ARC\\MODISMODIS\\MOD09A1.005\\")