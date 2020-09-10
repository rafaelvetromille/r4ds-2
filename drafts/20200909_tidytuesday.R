#' Author: Rafael Vetromille
#' Subject: TidyTuesday - Chopped

library(tidyverse)
library(magrittr)

# Import -----------------------------------------------------------------------

url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-25/chopped.tsv'
chopped <- readr::read_tsv(url)

# Os Jurados

chopped %>%
  mutate(judge1 = if_else(judge1 == "Amanda Freita", "Amanda Freitag", judge1),
         judge2 = if_else(judge2 == "Amanda Freita", "Amanda Freitag", judge2),
         judge3 = if_else(judge3 == "Amanda Freita", "Amanda Freitag", judge3),
         judge1 = if_else(judge1 == "Chris Santo", "Chris Santos", judge1),
         judge2 = if_else(judge2 == "Chris Santo", "Chris Santos", judge2),
         judge3 = if_else(judge3 == "Chris Santo", "Chris Santos", judge3)) %>%
  pivot_longer(
    starts_with("judge"),
    values_to = "nome_jurado",
    names_to = "nome",
  ) %>%
  count(nome_jurado) %>%
  filter(n > 5) %>%
  arrange(desc(n)) %>%
  ggplot(aes(y = fct_reorder(nome_jurado, n), x = n)) +
  geom_col() +
  labs(x = 'Número de Episódios', y = '')

# Ingredientes

chopped %>%
  pivot_longer(
    c(entree, appetizer, dessert),
    names_to = "prato",
    values_to = "ingredientes"
  ) %>%
  mutate(
    ingredientes = stringr::str_split(ingredientes, pattern = ", ")
  ) %>%
  dplyr::mutate(ingredientes = purrr::map(ingredientes, setNames, c("V1","V2","V3","V4","V5","V6"))) %>%
  unnest_wider(ingredientes) %>% view()
  mutate(ingredientes = stringr::str_remove_all(ingredientes, "[^A-Za-z ]") %>%
           str_squish() %>%
           tolower()) %>%
  count(ingredientes, sort = TRUE)


# Nota IMDB

chopped %>%
  pivot_longer(
    c(entree, appetizer, dessert),
    names_to = "prato",
    values_to = "ingredientes"
  ) %>%
  mutate(
    ingredientes = stringr::str_split(ingredientes, pattern = ", ")
  ) %>%
  unnest(ingredientes) %>%
  mutate(ingredientes = stringr::str_remove_all(ingredientes, "[^A-Za-z ]") %>%
           str_squish() %>%
           tolower()) %>%
  select(season, season_episode, ingredientes, episode_rating) %>%
  mutate(ingredientes = if_else(ingredientes == "a wagyu beef", "wagyu beef", ingredientes)) %>%
  group_by(ingredientes) %>%
  summarise(
    media = mean(episode_rating, na.rm = TRUE)
  ) %>%
  filter(is.finite(media)) %>%
  arrange(desc(media))

# Variabilidade de Ingredientes por Temporada

teste <- chopped %>%
  pivot_longer(
    c(entree, appetizer, dessert),
    names_to = "prato",
    values_to = "ingredientes"
  ) %>%
  mutate(
    ingredientes = stringr::str_split(ingredientes, pattern = ", ")
  ) %>%
  select(season, season_episode, prato, ingredientes) %>%
  unnest_wider(ingredientes,
               names_sep = "")

# Tidy -------------------------------------------------------------------------

# Visualize --------------------------------------------------------------------

# Model ------------------------------------------------------------------------

# Export -----------------------------------------------------------------------

# readr::write_rds(d, "")
