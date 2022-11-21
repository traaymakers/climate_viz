library(tidyverse)
library(scales)
library(patchwork)

watchlist2 <- read.csv("Data/WATCHLIST.csv") %>% 
  select(year = Year, runtime = Runtime..mins., rating = Your.Rating, movie = Title.Type, title = Title, id = Const, added = Created) %>% 
  drop_na() %>% 
  filter(movie != "short") #%>% 


watchlist2$year_added <- format(as.Date(watchlist2$added), "%Y")


overview <- aggregate(cbind(count = id) ~ year_added,
                          data = watchlist2,
                          FUN = function(x){NROW(x)})


filter(watchlist2$year_added <= 2013)  
# 
# hours <- totals$per_year/60
# totals$hours <- hours
# 
# cum_movies <- cumsum(totals$hours)
# totals$cumruntime <- cum_movies
# 
# av_year <- watchlist %>% 
#   group_by(year) %>% 
#   summarise(mean(runtime))
# totals$av_year <- av_year$`mean(runtime)`
# 
# movie_number <- aggregate(cbind(count = id) ~ year,
#                           data = watchlist,
#                           FUN = function(x){NROW(x)})
# totals$number <- movie_number$count
# 
# cum_number <- cumsum(totals$number)
# totals$cummovies <- cum_number


p1 <- ggplot(data = watchlist2, aes(x = year_added, y = year)) +
  geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) #+
  # geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
  # geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
  # scale_x_continuous(breaks = seq(1900, 2020, 10), expand=c(0,0)) +
  # scale_y_continuous(breaks = seq(0, max(totals$hours+5), 25), limits = c(0, max(totals$hours+5)), expand=c(0,0)) +
  # coord_cartesian(xlim = c(min(watchlist2$year), max(watchlist2$year+1))) +
  # scale_color_manual(name=NULL,
  #                    breaks=c(1, 2),
  #                    values = c("darkgrey", "blue"),
  #                    labels=c("Hours per release year", "LOWESS smoothing"),
  #                    guide = guide_legend(override.aes = list(shape=15, size = 2))) +
  # labs(x = "Release year",
  #      y = "Time (hours)",
  #      title = "Watch time per release year") +
  # theme_light() +
  # theme(axis.ticks = element_blank(),
  #       plot.title.position = "plot",
  #       plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
  #       legend.position = c(0.40, 0.9),
  #       legend.title = element_text(size=0),
  #       legend.text = element_text(size = 7),
  #       legend.key.height = unit(10, "pt"),
  #       legend.margin = margin(0,0,0,0))
p1
# 
# 
# p2 <- ggplot(data = totals, aes(x = year, y = cumruntime)) +
#   geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
#   geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
#   # geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
#   scale_x_continuous(breaks = seq(1900, 2020, 10), expand=c(0,0)) +
#   scale_y_continuous(breaks = seq(0, max(totals$cumruntime +100), 500), limits = c(0, max(totals$cumruntime +100)), expand=c(0,0)) +
#   coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
#   scale_color_manual(name=NULL,
#                      breaks=c(1, 2),
#                      values = c("red", "blue"),
#                      labels=c(" Cumulative hours", "LOWESS smoothing"),
#                      guide = guide_legend(override.aes = list(shape=15, size = 2))) +
#   labs(x = "Release year",
#        y = NULL,
#        title = "Cumulative watch time") +
#   theme_light() +
#   theme(axis.ticks = element_blank(),
#         plot.title.position = "plot",
#         plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
#         legend.position = c(0.40, 0.9),
#         legend.title = element_text(size=0),
#         legend.text = element_text(size = 7),
#         legend.key.height = unit(10, "pt"),
#         legend.margin = margin(0,0,0,0))
# 
# p3 <- ggplot(data = totals, aes(x = year, y = number)) +
#   geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
#   geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
#   geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
#   scale_x_continuous(breaks = seq(1900, 2020, 10), expand=c(0,0)) +
#   scale_y_continuous(breaks = seq(0, max(totals$number+5), 25), limits = c(0, max(totals$number+5)), expand=c(0,0)) +
#   coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
#   scale_color_manual(name=NULL,
#                      breaks=c(1, 2),
#                      values = c("black", "green"),
#                      labels=c("Movies per release year", "LOWESS smoothing"),
#                      guide = guide_legend(override.aes = list(shape=15, size = 2))) +
#   labs(x = NULL,
#        y = "# of movies",
#        title = "Movies per release year") +
#   theme_light() +
#   theme(axis.ticks = element_blank(),
#         plot.title.position = "plot",
#         plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
#         legend.position = c(0.40, 0.9),
#         legend.title = element_text(size=0),
#         legend.text = element_text(size = 7),
#         legend.key.height = unit(10, "pt"),
#         legend.margin = margin(0,0,0,0))
# 
# p4 <- ggplot(data = totals, aes(x = year, y = cummovies)) +
#   geom_line(aes(color = "1"), size = 0.5, show.legend = FALSE) +
#   geom_point(fill="white", aes(color = "1"), shape = 21, show.legend = TRUE) +
#   # geom_smooth(se=FALSE, aes(color = "2"), size=0.5, span=0.2, show.legend = FALSE) +
#   scale_x_continuous(breaks = seq(1900, 2020, 10), expand=c(0,0)) +
#   scale_y_continuous(breaks = seq(0, max(totals$cummovies +100), 250), limits = c(0, max(totals$cummovies +100)), expand=c(0,0)) +
#   coord_cartesian(xlim = c(min(watchlist$year), max(watchlist$year+1))) +
#   scale_color_manual(name=NULL,
#                      breaks=c(1, 2),
#                      values = c("orange", "blue"),
#                      labels=c(" Cumulative number of movies", "LOWESS smoothing"),
#                      guide = guide_legend(override.aes = list(shape=15, size = 2))) +
#   labs(x = NULL,
#        y = NULL,
#        title = "Cumulative movies") +
#   theme_light() +
#   theme(axis.ticks = element_blank(),
#         plot.title.position = "plot",
#         plot.title = element_text(margin = margin(b=10), color = "black", face = "bold"),
#         legend.position = c(0.40, 0.9),
#         legend.title = element_text(size=0),
#         legend.text = element_text(size = 7),
#         legend.key.height = unit(10, "pt"),
#         legend.margin = margin(0,0,0,0))
# 
# p3 + p4 + p1 + p2
# 
# ggsave("Figures/20220613_movie_stats2.pdf", width = 8, height = 5)
# ggsave("Figures/20220613_movie_stats2.png", width = 8, height = 5)



