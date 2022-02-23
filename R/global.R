
library(igraph)        # network analysis; create river network graphs
library(tidygraph)

library(nhdplusTools)  # R package for interafacing with NHDPlus
library(dataRetrieval) # R package for interfacing with NWIS data
library(sf)            # spatial analysis
library(rgeos)      #for clip
library(maptools)   #for clip
library(raster)
library(rgdal) #for projection
library(tidyverse)
library(broom)
library(ggnetwork)    #clean up igraph presentation?
library(ggplot2)
theme_set(theme_bw())
library(ggraph) #network graph pretty
library(lubridate)
library(dplyr)         # general data manipulation and cleaning
#library(magick) #create animation
source("../R/Network_MB_Analysis_Functions.R")


net <- graph.data.frame(d=edges_37,vertices=nodes_37,directed = T)
