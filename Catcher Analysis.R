library(quanteda) #important package
library(readtext)
library(stringi)
library(mosaic)

catcher <- texts(readtext("http://www.uzickagimnazija.edu.rs/files/Catcher%20in%20the%20Rye.pdf"))

names(catcher) <- "Catcher in the Rye" #rename the text

stri_sub(catcher, 1, 500) #check to see you got it, look at the first 500 characters

# Create a vector (list) of all the words in the novel
catcher_lower <- char_tolower(catcher)
catcher_words <- tokens(catcher_lower, remove_punct = TRUE) %>% as.character()
# INFO: tokens() function splits the text into words, as.character() casts the values into characters


seg <- char_segment(catcher_lower, pattern = "\\\n\\d+", valuetype = "regex")
chap_dfm <- dfm(seg)
(s <- dfm_lookup(chap_dfm, data_dictionary_LSD2015))
sdf <- data.frame(s)

# How many unique words are in Catcher?
(num_unique <- ntype(catcher_lower, remove_punct = TRUE))
# INFO: ntype() returns the number of "types" or unique words
# What percent are unique?
(num_unique/ntoken(catcher_lower, remove_punct = TRUE) * 100)
# ntoken returns the total number of words


# How many phony, phoniest, and phonies?
(num_phony <- nrow(kwic(catcher_lower, pattern = "goddam", valuetype = "regex")))
# INFO: kwic() returns a list of keywords. regular expressions are used to find patterns of language
# nrow returns the length of that list

# What percent of the novel is that?
print(num_phony / ntoken(catcher_lower, remove_punct = TRUE) * 100)


# Document-frequency matrix
catcher_dfm <- dfm(catcher_lower, remove_punct = TRUE)
dfm_lookup(catcher_dfm, data_dictionary_LSD2015)
head(catcher_dfm, nf = 10)
#head prints the first 10 entries


# Sorted list of word frequencies
catcher_dfm_nostop <- dfm_remove(catcher_dfm, pattern = stopwords('en'))
catcher_frequencies <- topfeatures(catcher_dfm_nostop, n = nfeat(catcher_dfm_nostop))
#top 10
catcher_frequencies[1:50]

#Gender ratios
male = catcher_frequencies["he"] + catcher_frequencies["him"] + catcher_frequencies{'guy'}
female = catcher_frequencies["she"] + catcher_frequencies["her"] + catcher_frequencies["gal"]
(male / female)


# Where does phony appear in the novel? phon(y|iest?)

textplot_xray(kwic(catcher_lower, pattern = "goddam"))

neg <- list(c("dark", "sad", "mad", "unhappy"))
neg <- dictionary(list(us = c("dark", "sad", "mad")))
pos <- c("light", "happy", "glad")

textplot_xray(
  kwic(catcher_lower, pattern = "phon(y|iest?)", valuetype = "regex"),
  kwic(catcher_lower, pattern = "goddam"),
  kwic(catcher_lower, pattern = neg),
  kwic(catcher_lower, pattern = "phoebe"),
  kwic(catcher_lower, pattern = data_dictionary_LSD2015["positive"]),
  scale = "absolute"
)

textplot_xray(kwic(catcher_lower, pattern = "happy", valuetype = "regex")) + labs(element_blank())

x <- "one time I thought that the white house did not exist and then i rembered the white house does exist white"
textplot_xray(kwic(x, pattern = c("white", "house"), valuetype = "regex"))
dfm_lookup(catcher_dfm, data_dictionary_LSD2015)

goddam <- kwic(catcher_lower, pattern = "goddam", window = 200, valuetype = "regex")
g <- data.frame(goddam)
goddam_use <- dfm(as.character(g["pre"]), remove_punct = TRUE)
goddam_use <- dfm_remove(goddam_use, pattern = stopwords('en'))
catcher_frequencies <- topfeatures(goddam_use, n = nfeat(goddam_use))








goddam_corp <- corpus(as.character(g["pre"]))
docvars(goddam_corp, "c") <- "goddam"

cat <- corpus(catcher_lower)
docvars(cat, "c") <- "cat"

murderVgeneral <- dfm(c(general, murder), remove_punc = TRUE) %>% 
  dfm_select(pattern = stopwords('en'), selection = 'remove')%>% 
  dfm_select(pattern = names, selection = 'remove')

#40, 9
#%>% dfm_trim(max_termfreq = 100000, min_docfreq = 9)

tstat_key <- textstat_keyness(murderVgeneral, target = (docvars(murderVgeneral, 'corpus') == "murder"))

head(tstat_key, 10)

textplot_keyness(tstat_key, show_reference = TRUE)





murder1 <- texts(readtext("violence_texts/*"))
murder <- char_tolower(murder)
murder <- corpus(murder)
docvars(murder, "corpus") <- "murder"

general1 <- texts(readtext("Random Compilation/*"))
general <- corpus(general)
docvars(general, "corpus") <- "general"

names <- c("â", "par", "verloc", "evelyn", "mcdermott", "easton", 
           "brett", "ted", "ossipon", "patrick", "œi", "patten", "varlocâ", "kalgan", "channis", "trantor",
           "toran", "bayta", "bret", "seldon", "hardin", "s", "n't", "nbsp", "pglaf.org")

stop <- c(texts(readtext("C:/Users/jackg/Desktop/Stalitstics/texts/LotOfStopWords.txt")), stopwords("en"))

murderVgeneral <- dfm(c(general, murder), remove_punc = TRUE) %>% 
  dfm_select(pattern = stopwords('en'), selection = 'remove')%>% 
  dfm_select(pattern = names, selection = 'remove')%>% 
  dfm_trim(min_termfreq = 20, min_docfreq = 9)

#40, 9
#

tstat_key <- textstat_keyness(murderVgeneral, target = (docvars(murderVgeneral, 'corpus') == "murder"))

head(tstat_key, 50)

textplot_keyness(tstat_key, show_reference = TRUE)






carver_pos = 
  data_frame(file = dir("C:/Users/jackg/Desktop/Stalitstics/texts/Murder Inspiration/*", full.names = TRUE)) %>%
  mutate(text = map(file, read_lines)) %>%
  transmute(work = basename(file), text) %>%
  unnest(text) %>% 
  unnest_tokens(word, text, token='words') %>% 
  inner_join(parts_of_speech) %>% 
  count(pos) %>%
  mutate(work='love',
         prop=n/sum(n))



install.packages("openNLPmodels.en", repos = "http://datacube.wu.ac.at/", type = "source")

library(tidytext)



murder_dfm <- dfm(murder, remove_punc = TRUE)  %>% 
  dfm_select(pattern = stopwords('en'), selection = 'remove')%>% 
  dfm_select(pattern = names, selection = 'remove')
# %>% 
#   dfm_trim(min_termfreq = 10, min_docfreq = 2)
docvars(murder_dfm, "type") <- "murder"

general_dfm <- dfm(general, remove_punc = TRUE)  %>% 
  dfm_select(pattern = stopwords('en'), selection = 'remove')%>% 
  dfm_select(pattern = names, selection = 'remove')
docvars(general_dfm, "type") <- "general"

dfm_lookup(murder_dfm, data_dictionary_LSD2015)
dfm_lookup(general_dfm, data_dictionary_LSD2015)

(textstat_readability(murder1, measure="Flesch.Kincaid"))
(textstat_readability(general1, measure="Flesch.Kincaid"))

mean(textstat_lexdiv(murder_dfm, measure = "Vm")$Vm)
mean(textstat_lexdiv(general_dfm, measure = "Vm")$Vm)

# Sorted list of word frequencies
freq_murder <- topfeatures(murder_dfm, n = nfeat(murder_dfm))
#top 10

# Sorted list of word frequencies
freq_general <- topfeatures(general_dfm, n = nfeat(general_dfm))
#top 10

freq_murder["murder"]/nfeat(murder_dfm)
freq_general["murder"]/nfeat(general_dfm)

positive <- texts(readtext("C:/Users/jackg/Desktop/Stalitstics/texts/positive.txt"))

