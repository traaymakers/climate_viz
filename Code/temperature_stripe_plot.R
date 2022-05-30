library(tidyverse)
library(scales)

t_data <- read.csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>% 
  select(year = Year, t_diff = 'J.D') %>% 
  drop_na()

t_data %>% 
  ggplot(aes(x = year, y = 1, fill = t_diff)) +
  geom_tile(show.legend = FALSE) +
  scale_fill_stepsn(colors = c("#08306B", "white", "#67000D"),
                    values = rescale(c(min(t_data$t_diff), 0, max(t_data$t_diff))),
                    n.breaks = 12) +
  coord_cartesian(expand = FALSE) +
  theme_void()