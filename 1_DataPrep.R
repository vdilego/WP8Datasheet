#extract and save data in automated way.

library(eurostat)
library(tidyverse)
library(here)
library(data.table)
library(ggplot2)
library(countrycode)
library(ggthemes)

options(scipen=999)

# creating directory folders where outputs are saved
# for figures
# for data

hly.folder <- here("Data", "HLY") 
hale.folder <- here("Data", "HALE") 
wahe.folder <- here("Data", "WAHE") 
srh.folder <- here("Data", "SRH") 


# make in-out directories

#dir.create(hly.folder , showWarnings = FALSE, recursive = TRUE)
#dir.create(hale.folder , showWarnings = FALSE, recursive = TRUE)
#dir.create(wahe.folder , showWarnings = FALSE, recursive = TRUE)
#dir.create(srh.folder , showWarnings = FALSE, recursive = TRUE)


# download data

# first HLY - official statistics from eurostat

## Retrieve HLY directly from Eurostat across years

data.hly <- get_eurostat("hlth_hlye", time_format = "num") %>%
  filter(unit%in%"YR") %>%
  separate(3,into = c("indic","age"), sep="_") %>%
  filter(indic%in%"HLY" & geo!= "CH") %>% 
  mutate(geo=countrycode(geo, "eurostat","country.name",
                         custom_match = c('EU27_2020' = 'EU27', "EU28"="EU28" )))

write.table(data.hly, here(hly.folder, "hly.csv"), sep=",", row.names = F)

# HALE


