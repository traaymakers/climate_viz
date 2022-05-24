library(tidyverse)

t_data <- read.csv("Data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>%
  select(year = Year, t_diff = 'J.D') %>%
  drop_na() 

annotation <- t_data %>%
  arrange(year) %>% 
  slice(1, n()) %>% 
  mutate(t_diff = 0,
         z = year + c(-5, 5))

t_data %>%
  ggplot(aes(x=year, y=t_diff, fill=t_diff)) +
  geom_col() +
  geom_text(data = annotation, aes(x=z, label=year), color = "white") +
  scale_fill_gradient2(low = "darkblue", mid = "white", high = "darkred",
                       midpoint = 0, limits = c(-0.5, 1.5)) +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "black"),
    legend.text = element_text(color = "white")
  )

ggsave("Figures/temperature_bar_plot.pdf", width = 7, height = 4)
