
library(dplyr)
library(readr)
library(stringr)
library(ggplot2);theme_set(theme_minimal())

# import data

kaggle <- read_csv("kagglesurvey.csv")

View(kaggle); glimpse(kaggle)

# counting the number of users

kaggle %>% 
  group_by(LanguageRecommendationSelect) %>% 
  count() %>% 
  arrange(desc(n))

# Lets view the number of users of R, Python or Others

multiple_tools <- kaggle %>% 
  mutate(
    Tools =case_when(
      str_detect(WorkToolsSelect, "R") & !str_detect(WorkToolsSelect, "Python") ~ "R",
      str_detect(WorkToolsSelect, "Python") & !str_detect(WorkToolsSelect, "R") ~ "Python",
      str_detect(WorkToolsSelect, "R") & str_detect(WorkToolsSelect, "Python") ~ "Both",
      !str_detect(WorkToolsSelect, "R") & !str_detect(WorkToolsSelect, "Python") ~ "Others"
      
    )
)
# visualise the most used tools 

  multiple_tools %>%
  count(Tools) %>%
  group_by(Tools) %>%
  ggplot(aes(reorder(Tools, n), n)) +
  geom_col() +
    coord_flip()

