library(tidyverse)
library(glue)
library(scales)

watchlist <- read.csv("Data/WATCHLIST.csv") %>% 
  select(year = Year, runtime = Runtime..mins., rating = Your.Rating, movie = Title.Type, title = Title) %>% 
  filter(movie != "short")
  # filter(year == 2009)
  
totals <- watchlist %>% 
  group_by(year) %>% 
  summarise_at(vars(runtime),
               list(per_year = sum))
# totals


ggplot(data = totals, aes(x = year, y = per_year)) +
         geom_line() +
  coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year)))

       

# 
# read.csv("Data/GLB.Ts+dSST.csv", skip=1, na = "***") %>%
#   select(year = Year, t_diff = 'J.D') %>%
#   drop_na() %>% 
#   ggplot(aes(x=year, y=t_diff)) +
#   geom_line(aes(color = "1"), size=0.5, show.legend = FALSE) +
#   geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
#   geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.15, show.legend = FALSE) +
#   scale_x_continuous(breaks = seq(1880, 2023, 20), expand=c(0,0)) + 
#   scale_y_continuous(limits = c(-0.5, 1.5), expand=c(0,0)) + 
#   scale_color_manual(name=NULL,
#                      breaks=c(1, 2),
#                      values = c("gray", "black"),
#                      labels=c("Annual mean", "Lowess smoothing"),
#                      guide = guide_legend(override.aes = list(shape=15, size = 5))) +
#   labs(
#     x = "YEAR",
#     y = "Temperature anomaly (\u00B0C)",
#     title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
#     subtitle = "Data source: NASA's Goddard Institute for Space Studies (GISS). \nCredit: NASA/GISS" 
#   ) +
#   theme_light() +
#   theme(
#     axis.ticks = element_blank(),
#     plot.title.position = "plot",
#     plot.title = element_text(margin = margin(b=10), color = "red", face = "bold"),
#     plot.subtitle = element_text(size=8, margin = margin(b=10)),
#     legend.position = c(0.15, 0.9),
#     legend.title = element_text(size=0),
#     legend.key.height = unit(10, "pt"),
#     legend.margin = margin(0,0,0,0))
# 
# ggsave("Figures/temperature_index_plot.pdf", width = 6, height = 4)



#   select(year = Year, t_diff = 'J.D') %>%
#   drop_na() 
# 
# annotation <- t_data %>%
#   arrange(year) %>% 
#   slice(1, n()) %>% 
#   mutate(t_diff = 0,
#          z = year + c(-5, 5))
# 
# max_t_diff <- format(round(max(t_data$t_diff), 1), nsmall = 1)
# 
# t_data %>%
#   ggplot(aes(x=year, y=t_diff, fill=t_diff)) +
#   geom_col(show.legend = FALSE) +
#   geom_text(data = annotation, aes(x=z, label=year), color = "white") +
#   geom_text(x=1880, y=1, hjust = 0,
#             label =glue("Global temperatures have increased by over {max_t_diff}\u00B0C since {min(t_data$year)}"),
#             color="white") +
#   # scale_fill_gradient2(low = "darkblue", mid = "white", high = "darkred",
#   #                      midpoint = 0, limits = c(-0.5, 1.5)) +
#   # scale_fill_gradientn(colors = c("darkblue", "white", "darkred"),
#   #                      values = rescale(c(min(t_data$t_diff), 0, max(t_data$t_diff))),
#   #                      limits = c(min(t_data$t_diff), max(t_data$t_diff))) +
#   scale_fill_stepsn(colors = c("darkblue", "white", "darkred"),
#                     values = rescale(c(min(t_data$t_diff), 0, max(t_data$t_diff))),
#                     limits = c(min(t_data$t_diff), max(t_data$t_diff)),
#                     n.breaks = 9) +
#     theme_void() +
#   theme(
#     plot.background = element_rect(fill = "black"),
#     legend.text = element_text(color = "white")
#   )
# 
# ggsave("Figures/temperature_bar_plot.pdf", width = 7, height = 4)
