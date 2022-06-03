library(tidyverse)
library(glue)

t_diff <- read.csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>% 
  select(year = Year, month.abb) %>% 
  pivot_longer(-year, names_to = "month", values_to = "t_diff") %>% 
  drop_na() 

# last_dec <- t_diff %>% 
#   filter(month == "Dec") %>% 
#   mutate(year = year +1, 
#          month = "last_Dec")

next_jan <- t_diff %>%
  filter(month == "Jan") %>%
  mutate(year = year -1,
         month = "next_Jan")

t_data <- bind_rows(t_diff, next_jan) %>%
  mutate(month = factor(month,
                        levels = c(month.abb, "next_Jan")),
         month_number = as.numeric(month) -1) 

# annotation <- t_data %>% 
#   slice_max(year) %>% 
#   slice_max(month_number)

t_data %>% 
  ggplot(aes(x=month_number, y=t_diff, group=year, color=year)) +
  geom_hline(yintercept = 0, color="white") +
  geom_line() +
  scale_x_continuous(breaks = 1:12,
                     labels=month.abb,
                     sec.axis = dup_axis(name = NULL, labels = NULL)) +
  scale_y_continuous(breaks = seq(-2, 2, 0.2),
                     sec.axis = dup_axis(name = NULL, labels = NULL)) +
  scale_color_viridis_c(breaks = seq(1880, 2020, 20),
                        guide = "none") +
  # coord_cartesian(xlim = c(1,12)) +
  coord_polar() +
  labs(x = NULL, 
       y = NULL,
       title = glue("Global temperature change {min(t_data$year)+1}-{max(t_data$year)}")) +
  theme(
    panel.background = element_rect(fill = "black", color = "white", size = 1),
    plot.background = element_rect(fill = "#444444"),
    panel.grid = element_blank(),
    axis.text = element_text(color = "white", size = 13),
    axis.text.y = element_blank(),
    # axis.ticks = element_line(color = "white"),
    # axis.ticks.length = unit(-5, "pt"),
    axis.title = element_blank(),
    plot.title = element_text(color = "white", hjust = 0.5, size = 15),
  )

ggsave("Figures/climate_spiral.pdf", width = 8, height = 4.5)