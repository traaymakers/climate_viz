library(tidyverse)

t_diff <- read.csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>% 
  select(year = Year, month.abb) %>% 
  pivot_longer(-year, names_to = "month", values_to = "t_diff") %>% 
  drop_na() 

last_dec <- t_diff %>% 
  filter(month == "Dec") %>% 
  mutate(year = year -1, 
         month = "last_Dec")

next_jan <- t_diff %>% 
  filter(month == "Jan") %>% 
  mutate(year = year +1, 
         month = "next_Jan")

bind_rows(last_dec, t_diff, next_jan) %>%  
  mutate(month = factor(month,
                        levels = c("last_Dec", month.abb, "next_Jan"))) %>% 
  ggplot(aes(x=month, y=t_diff, group=year, color=year)) +
  geom_line()