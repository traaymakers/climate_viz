library(tidyverse)
library(scales)
library(patchwork)

watchlist <- read.csv("Data/WATCHLIST.csv") %>% 
  select(year = Year, runtime = Runtime..mins., rating = Your.Rating, movie = Title.Type, title = Title) %>% 
  drop_na() %>% 
  filter(movie != "short") #%>% 
  # filter(year == 2016)
  
totals <- watchlist %>% 
  group_by(year) %>% 
  summarise_at(vars(runtime),
               list(per_year = sum))

cum_movies <- cumsum(totals$per_year)
totals$cumruntime <- cum_movies
  
# totals


p1 <- ggplot(data = totals, aes(x = year, y = per_year)) +
  geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
  geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
  geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
  scale_x_continuous(breaks = seq(1900, 2020, 10), expand=c(0,0)) +
  scale_y_continuous(limits = c(0, max(totals$per_year+500)), expand=c(0,0)) +
  coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
  scale_color_manual(name=NULL,
                     breaks=c(1, 2),
                     values = c("darkgrey", "blue"),
                     labels=c("Minutes per release year", "LOWESS smoothing"),
                     guide = guide_legend(override.aes = list(shape=15, size = 5))) +
  labs(x = "Release year",
       y = "Total minutes per release year",
       title = "Cumulative time of movies watched per year") +
  theme_light() +
  theme(axis.ticks = element_blank(),
        plot.title.position = "plot",
        plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
        legend.position = c(0.20, 0.9),
        legend.title = element_text(size=0),
        legend.key.height = unit(10, "pt"),
        legend.margin = margin(0,0,0,0))
# ggsave("Figures/movie_stats1.pdf", width = 6, height = 4)

p2 <- ggplot(data = totals, aes(x = year, y = cumruntime)) +
  geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
  geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
  # geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
  scale_x_continuous(breaks = seq(1900, 2020, 10), expand=c(0,0)) +
  scale_y_continuous(limits = c(0, max(totals$cumruntime +500)), expand=c(0,0)) +
  coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
  scale_color_manual(name=NULL,
                     breaks=c(1, 2),
                     values = c("red", "blue"),
                     labels=c("Minutes per release year", "LOWESS smoothing"),
                     guide = guide_legend(override.aes = list(shape=15, size = 5))) +
  labs(x = "Release year",
       y = "Total minutes per release year",
       title = "Cumulative time of movies watched per year") +
  theme_light() +
  theme(axis.ticks = element_blank(),
        plot.title.position = "plot",
        plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
        legend.position = c(0.20, 0.9),
        legend.title = element_text(size=0),
        legend.key.height = unit(10, "pt"),
        legend.margin = margin(0,0,0,0))


  
  

