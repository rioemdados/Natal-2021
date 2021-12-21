# Pacotes
library(readr)
library(dplyr)
library(tm)
library(wordcloud2)
library(tidytext)

# Lendo o arquivo que contém a letra da música
df  <- read_csv("All_I_Want_For_Christmas.txt")

# Lista de stopwords em português
stopwords_en <- data.frame(word = tm::stopwords("english"))

# Quebrando as frases em palavras 
words <- df %>% 
  select(music) %>% 
  unnest_tokens(word, music, token = "ngrams", n = 1) %>% 
  # Removendo stopwords
  dplyr::anti_join(stopwords_en, by = c("word" = "word"))

# Contando cada palavra que apareceu na letra
text <- words %>% 
  count(word) %>%
  rename(freq=n)

# Criando a wordcloud
wordcloud2(text, size = 0.4, shape = 'star', fontFamily = 'serif', color = rep(c('green','red'), each = 10, length.out = dim(text)[1]))

