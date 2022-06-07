library(tidyverse)
library(glue)
library(gganimate)
library(gifski)

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
         month_number = as.numeric(month)) %>% 
  arrange(year, month) %>% 
  filter(year != 1879) %>% 
  mutate(step_number = 1:nrow(.))

annotation <- t_data %>%
  slice_max(year) %>%
  slice_max(month_number)

# maxyear <- t_diff %>% 
#   slice_max(year) 

temp_lines <- tibble(
  top = 12,
  temps = c(1.5, 2.0),
  labels = c("1.5\u00B0C", "2.0\u00B0C")
)

month_labels <- tibble(
  m = 1:12,
  month_loc = 2.8,
  labels = month.abb,
)

t_data %>% 
  ggplot(aes(x=month_number, y=t_diff, group=year, color=year)) +
  geom_rect(aes(xmin = 1, xmax = 13, ymin = -2, ymax = 2.4),
            color = "black", fill = "black",
            inherit.aes = FALSE) +
  # geom_col(data = month_labels, aes(x=m +0.5, y=2.4), fill = "black",
  #          width = 1,
  #          inherit.aes = FALSE) +
  # geom_col(data = month_labels, aes(x=m +0.5, y=-2), fill = "black",
  #          width = 1,
  #          inherit.aes = FALSE) +
  geom_hline(yintercept = c(1.5, 2.0), color="red") +
  geom_label(data = temp_lines, aes(x=top, y=temps, label=labels),
             color = "red", fill = "black", label.size = 0,
             inherit.aes = FALSE) +
  geom_text(data = month_labels, aes(x=m, y=month_loc, label=labels),
            inherit.aes = FALSE, color = "lightgrey",
            angle = seq(360 - 360/12, 0, length.out = 12)) +
  geom_label(aes(x = 1, y = -1.33, label = year),
             color = "white", fill = "black",
             label.padding = unit(50, "pt"),
             label.size = 0, size = 6) +
  geom_line() +
  scale_x_continuous(breaks = 1:12, expand = c(0,0),
                     labels=month.abb,
                     sec.axis = dup_axis(name = NULL, labels = NULL)) +
  scale_y_continuous(breaks = seq(-2, 2, 0.2), expand = c(0,-0.7),
                     limits = c(-2, 2.8),
                     sec.axis = dup_axis(name = NULL, labels = NULL)) +
  scale_color_viridis_c(breaks = seq(1880, 2020, 20),
                        guide = "none") +
  coord_polar(start = 2*pi/12) +
  labs(x = NULL, 
       y = NULL,
       title = glue("Global temperature change {min(t_data$year)}-{max(t_data$year)}")) +
  theme(
    panel.background = element_rect(fill = "#444444", size = 1),
    plot.background = element_rect(fill = "#444444", color = "#444444"),
    panel.grid = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.title = element_text(color = "white", hjust = 0.5, size = 15),
  ) +
  transition_reveal(along = step_number)

# ggsave("Figures/climate_spiralm.gif", width = 8, height = 4.5)



