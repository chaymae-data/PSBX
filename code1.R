
#extraire le contenu du pdfavec un package pdftools
install.packages("pdftools")
library(pdftools)
download.file(docs, mode = "wb")
text <- pdf_text("I%20Have%20a%20Dream%20by%20Martin%20Luther%20King%20Jr.pdf")
text1 <- strsplit(text, "\n")
cat(text[1])

#extriare le contenu avec un package tm 
install.packages("tm")
library(tm)
#La fonction getwd() affiche la localisation du r�pertoire de travail sous la forme d'un chemin absolu
docs <- getwd()
#charger les donn�es dans un corpus
my_corpus <- VCorpus(DirSource(docs, pattern = ".pdf"), 
                     readerControl = list(reader = readPDF))
inspect(my_corpus)
#afficher le document1 du corpus
writeLines(as.character(my_corpus[[1]]))
#mettre des espaces entre a cot� des endroits d�sir�s
toSpace<-content_transformer(function(x,pattern) {return(gsub(pattern," ",x))})
my_corpus<-tm_map(my_corpus,toSpace,"-")
my_corpus<-tm_map(my_corpus,toSpace,",")
my_corpus<-tm_map(my_corpus,toSpace,"!")
my_corpus<-tm_map(my_corpus,toSpace,"--")
my_corpus<-tm_map(my_corpus,toSpace,"'")

writeLines(as.character(my_corpus[[2]]))

#supprimer les ponctuations
my_corpus<-tm_map(my_corpus, removePunctuation)
#transformer le contenu en minuscule
my_corpus<- tm_map(my_corpus, content_transformer(tolower))
#supprimer les nombre
my_corpus<- tm_map(my_corpus, removeNumbers)
#Supprimer les  mots vides anglais
my_corpus<- tm_map(my_corpus, removeWords, stopwords("english"))
writeLines(as.character(my_corpus[[2]]))
#Supprimer les espaces vides suppl�mentaires
my_corpus<- tm_map(my_corpus, stripWhitespace)

#installer le pckage snowballC
install.packages("SnowballC")
library(SnowballC)
#text stemming
my_corpus<- tm_map(my_corpus, stemDocument)
#construire une matrice des mots
dtm <- DocumentTermMatrix(my_corpus)
inspect(dtm)
#afficher ka fr�quences des mots utilis�s dans le corpus
freq<-colSums(as.matrix(dtm))
#trier la fr�quence des mots par ordre d�croissant
ord<-order(freq,decreasing = TRUE)
#afficher les mots les moins utilis�s
freq[tail(ord)]
#afficher les plus utilis�s
freq[head(ord)]





