library(tidyverse)

read.csv("Data/GLB.Ts+dSST.csv", skip=1, na = "***") %>%
  select(year = Year, t_diff = 'J.D') %>%
  ggplot(aes(x=year, y=t_diff)) +
  geom_line(color = "gray", size=0.5) +
  geom_point(fill="white", color="gray", shape = 21) +
  geom_smooth(se=FALSE, color = "black", size=0.5, span=0.15) +
  theme_light()

ggsave("Figures/temperature_index_plot.png", width = 6, height = 4)
  