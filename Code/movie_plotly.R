library(tidyverse)
library(scales)
library(patchwork)
library(plotly)
library(quantmod)
library(htmlwidgets)

watchlist <- read.csv("Data/WATCHLIST.csv") %>%
  select(year = Year, runtime = Runtime..mins., rating = Your.Rating, movie = Title.Type, title = Title, id = Const) %>%
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

av_year <- watchlist %>%
  group_by(year) %>%
  summarise(mean(runtime))
totals$av_year <- av_year$`mean(runtime)`

movie_number <- aggregate(cbind(count = id) ~ year,
                          data = watchlist,
                          FUN = function(x){NROW(x)})
totals$number <- movie_number$count

cum_number <- cumsum(totals$number)
totals$cummovies <- cum_number


fig <- plot_ly(totals, x = ~year)
fig <- fig %>% add_lines(y = ~number, name = "Number of moveis")
# fig <- fig %>% add_lines(y = ~MSFT.Adjusted, name = "Microsoft")
fig <- fig %>% layout(
  title = "Movie watchlist",
  xaxis = list(
    rangeselector = list(
      buttons = list(
        # list(
        #   count = 3,
        #   label = "3 mo",
        #   step = "month",
        #   stepmode = "backward"),
        # list(
        #   count = 6,
        #   label = "6 mo",
        #   step = "month",
        #   stepmode = "backward"),
        list(
          count = 1,
          label = "1 yr",
          step = "year",
          stepmode = "backward"),
        # list(
        #   count = 1,
        #   label = "YTD",
        #   step = "year",
        #   stepmode = "todate"),
        list(step = "all"))),
    
    rangeslider = list(type = "date")),
  
  yaxis = list(title = "# movies per release year"))

fig

saveWidget(fig, "Figures/20220622_movie_stats.html")