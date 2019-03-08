# input and clean dataset
# ben.williams@alaska.gov
# revised 2019-03

# load ----
source('code/helper.r')

# data ----
read_csv('data/DATA_EVENTS.csv') %>% 
  rename_all(tolower) -> event_data

read_csv('data/DATA_CATCH_COMP.csv') %>% 
  rename_all(tolower) -> catch_comp_data

read_csv('data/DATA_AWL_GROUNDFISH.csv') %>% 
  rename_all(tolower) -> g_awl_data 

# combine and filter data
event_data %>% glimpse
catch_comp_data %>% glimpse

# need to remove species_codes with "R" and turn into a numeric value
catch_comp_data %>% 
  filter(!grepl("R", species_code)) %>% 
  mutate(species_code = as.numeric(species_code)) -> catch_comp_df

# join all three data sets
event_data %>% 
  left_join(catch_comp_df) %>% 
  left_join(g_awl_data) %>% 
  mutate(date_set = mdy_hm(date_set),
         date_hauled = mdy_hm(date_hauled)) %>% 
  dplyr::select(year, station_id, date_set, slat = start_latitude, slong = start_longitude,
                elat = end_latitude, elong = end_longitude, min_depth = minimum_depth,
                max_depth = maximum_depth, species_code, common_name, count, 
                sample = sample_wt_kg, catch_weight) -> sample_wt

write_csv(sample_wt, 'output/sample_wt.csv')

