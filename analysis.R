library(ggplot2)
library(leaflet)
library(dplyr)
library(plotly)

#analyze midwest data
?midwest

#add midwest to a variable called data
data <- midwest

#How many rows are in data
num_counties <- nrow(data)

#what is the sum of the population in data
total_population <- sum(data$poptotal)

#what is the sum of the asian population
total_asian <- sum(data$popasian)

#Get the state with the max state_total from the data
highest_state <- data %>% group_by(state) %>% 
  summarize(state_total = n()) %>%
  filter(state_total == max(state_total))

# create a scatter plot of your data 
data <- data %>% mutate(hover_text = paste0(county, ", ", state, "<br>", 
                                            "Total Population: ", total_population))

scatter <- plot_ly(data,
                   x = ~poptotal,
                   y = ~popdensity,
                   text = ~hover_text,
                   hoverinfo = "text",
                   type = "scatter",
                   mode = "markers",
                   marker = list(
                     color = "red",
                     opacity = .2,
                     size = 10
                   )
) %>%
  layout(
    xaxis = list(
      range = c(0, max(data$poptotal) + 3),
      zeroline = FALSE
    ),
    yaxis = list(
      range = c(0, max(data$popdensity) + 3),
      zeroline = FALSE
    )
  )