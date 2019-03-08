# basic trawl analysis on sample weight
# ben.wlliams@alaska.giv
# 2019-03 

# load ----
source('code/helper.r')

# data ----
read_csv('output/sample_wt.csv') %>% 
  mutate(Year = factor(year)) -> sample_wt

# eda ----
unique(sample_wt$common_name)

# just pollock 
sample_wt %>% 
  filter(common_name=="pollock, walleye") %>% 
  ggplot(aes(min_depth, catch_weight)) +
  geom_point() +
  facet_wrap(~year)

# make a map
ggplot() +
  geom_polygon(data = ak, aes(long, lat, group = group), fill = 8, color = 'black') +
  coord_map(xlim = c(-155, -145), ylim = c(58, 61.5)) +
  xlab(expression(paste(Longitude^o,~'W'))) +
  ylab(expression(paste(Latitude^o,~'N'))) +
  geom_point(data = sample_wt, aes(slong, slat), color = 4)

# color by year
ggplot() +
  geom_polygon(data = ak, aes(long, lat, group = group), 
               fill = 8, color = 'black') +
  coord_map(xlim = c(-155, -145), ylim = c(58, 61.5)) +
  xlab(expression(paste(Longitude^o,~'W'))) +
  ylab(expression(paste(Latitude^o,~'N'))) +
  geom_point(data = sample_wt, aes(slong, slat, color = Year)) 

# ggsave('figs/map_1.png', dpi = 200, height = 5, width = 5, units = "in")

# catch by average depth
sample_wt %>% 
  mutate(depth = (min_depth + max_depth) / 2) %>% 
  ggplot(aes(depth, catch_weight, group = Year, 
             color = Year, fill = Year)) + 
  # geom_point() +
  stat_smooth(alpha = .1) +
  coord_cartesian(ylim = c(0, 2500))

# catch by average depth
sample_wt %>% 
  mutate(depth = (min_depth + max_depth) / 2,
         log_depth = log(depth)) %>% 
  ggplot(aes(log_depth, catch_weight, group = Year, 
             color = Year, fill = Year)) + 
  # geom_point() +
  stat_smooth(alpha = .1, method = 'lm') +
  # coord_cartesian(ylim = c(0, 2500)) +
  # scale_x_log10() +
  scale_y_log10()



