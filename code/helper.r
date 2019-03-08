library(tidyverse)
library(lubridate)
library(PBSmapping)
data('nepacLLhigh') 

nepacLLhigh %>% 
  dplyr::select(group=PID, POS, long=X, lat=Y) -> ak 
library(FNGr)
theme_set(theme_sleek())
library(mgcv)
