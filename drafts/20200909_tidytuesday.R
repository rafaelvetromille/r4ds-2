#' Author: Rafael Vetromille
#' Subject: TidyTuesday - Chopped

library(tidyverse)
library(magrittr)

# Import -----------------------------------------------------------------------

url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-08-25/chopped.tsv'
chopped <- readr::read_tsv(url)

# Tidy -------------------------------------------------------------------------

# Visualize --------------------------------------------------------------------

# Model ------------------------------------------------------------------------

# Export -----------------------------------------------------------------------

# readr::write_rds(d, "")
