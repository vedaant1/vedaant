# Please install these packages if you do not already have them

install.packages('png')
install.packages('ggimage')
install.packages('grid')
install.packages('patchwork')

library(tidyverse)

penalty = read_csv(file = 'data/WorldCupShootouts.csv')

penalty_new = penalty |>
  select(Year, Match, Team, Country, everything()) |>
  select(-Game_id, -Team) |>
  drop_na()

write_csv(x = penalty_new, file = 'data/penalty.csv')
