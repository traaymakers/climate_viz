library(tidyverse)
library(scales)
library(patchwork)

watchlist <- read.csv("Data/WATCHLIST.csv") %>% 
  select(year = Year, runtime = Runtime..mins., rating = Your.Rating, movie = Title.Type, title = Title) %>% 
  drop_na() %>% 
  filter(movie != "short") #%>% 
  #filter(year == 2022)
  
totals <- watchlist %>% 
  group_by(year) %>% 
  summarise_at(vars(runtime),
               list(per_year = sum))

hours <- totals$per_year/60
totals$hours <- hours

cum_movies <- cumsum(totals$hours)
totals$cumruntime <- cum_movies
  
# totals


p1 <- ggplot(data = totals, aes(x = year, y = hours)) +
  geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
  geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
  geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
  scale_x_continuous(breaks = seq(1900, 2020, 20), expand=c(0,0)) +
  scale_y_continuous(breaks = seq(0, max(totals$hours+60), 25), limits = c(0, max(totals$hours+60)), expand=c(0,0)) +
  coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
  scale_color_manual(name=NULL,
                     breaks=c(1, 2),
                     values = c("darkgrey", "blue"),
                     labels=c("Hours per release year", "LOWESS smoothing"),
                     guide = guide_legend(override.aes = list(shape=15, size = 3))) +
  labs(x = "Release year",
       y = "Total hours per release year",
       title = "Watch time per release year") +
  theme_light() +
  theme(axis.ticks = element_blank(),
        plot.title.position = "plot",
        plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
        legend.position = c(0.40, 0.9),
        legend.title = element_text(size=0),
        legend.key.height = unit(10, "pt"),
        legend.margin = margin(0,0,0,0))


p2 <- ggplot(data = totals, aes(x = year, y = cumruntime)) +
  geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
  geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
  # geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
  scale_x_continuous(breaks = seq(1900, 2020, 20), expand=c(0,0)) +
  scale_y_continuous(breaks = seq(0, max(totals$cumruntime +50), 500), limits = c(0, max(totals$cumruntime +50)), expand=c(0,0)) +
  coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
  scale_color_manual(name=NULL,
                     breaks=c(1, 2),
                     values = c("red", "blue"),
                     labels=c(" Cumulative hours", "LOWESS smoothing"),
                     guide = guide_legend(override.aes = list(shape=15, size = 3))) +
  labs(x = "Release year",
       y = NULL,
       title = "Cumulative watch time") +
  theme_light() +
  theme(axis.ticks = element_blank(),
        plot.title.position = "plot",
        plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
        legend.position = c(0.40, 0.9),
        legend.title = element_text(size=0),
        legend.key.height = unit(10, "pt"),
        legend.margin = margin(0,0,0,0))
p1 + p2

ggsave("Figures/20220613_movie_stats.pdf", width = 6, height = 4)
ggsave("Figures/20220613_movie_stats.png", width = 6, height = 4)

  

