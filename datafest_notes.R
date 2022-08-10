#Filtering data

library(data.table)
library(dplyr)
library(tidyverse)

data <- fread("logs.csv")
data <- as.tibble(data)
head(data)
dim(data)
new_data <- data %>%
  filter(event_id == 304|event_id ==602) %>% 
  select(player_id, event_id, avatar_age, avatar_gender, avatar_id, aa_level_id, chunk_id, piece_id, old_choice_id, old_label, 
         new_choice_id, new_label) %>% 
  group_by(player_id)
new_data <- new_data %>% 
  filter(aa_level_id == 0 & chunk_id == 3 & piece_id == 0)
View(new_data)
  
write.csv(new_data, "/Users/alyssalung/Desktop/DATAFEST/updated_data.csv")

avatar_data <- data %>% 
  select(player_id, avatar_gender, avatar_id, avatar_age) %>% 
  filter(!is.na(avatar_id))
write.csv(avatar_data,  "/Users/alyssalung/Desktop/DATAFEST/avatar_data.csv")

refusal <- data %>% 
  filter(minigame_id == 3) %>% 
  select (player_id, event_id, minigame_id, minigame_level) %>% 
  group_by(minigame_level)
View(refusal)

importance <- data %>% 
  filter(event_id == 304 & aa_level_id == 7) %>% 
  select (player_id, aa_level_id, chunk_id, new_choice_id, piece_id)

importance <- importance %>% 
  filter(chunk_id == 2) 
dim(importance)
View(importance)

importance <- write.csv(importance, "/Users/alyssalung/Desktop/DATAFEST/importance.csv" )
