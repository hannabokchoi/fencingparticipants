entrants.df <- read.csv("NZ University Games Entry Form (Responses) - Form responses 1.csv", header = T)[,c(3,7:9)]
nathan <- which(entrants.df=="Nathan Mcknight")
detroit <- which(entrants.df=="Detroit James Evans")
qihang <- min(which(entrants.df == "Qihang Shi"))
entrants.df <- entrants.df[-c(nathan,detroit,qihang),]
imms <- data.frame("Andrew Imms", "Sabre", "Epee", "Foil")
names(imms) <- c("Full.name", "Main.weapon", "Second.weapon", "Third.weapon")
entrants.df <- rbind(entrants.df,imms)
sabrefencers <- c(entrants.df[,1][entrants.df[,2]=="Sabre"],entrants.df[,1][entrants.df[,3]=="Sabre"],entrants.df[,1][entrants.df[,4]=="Sabre"])
epeefencers <- c(entrants.df[,1][entrants.df[,2]=="Epee"],entrants.df[,1][entrants.df[,3]=="Epee"],entrants.df[,1][entrants.df[,4]=="Epee"])
foilfencers <- c(entrants.df[,1][entrants.df[,2]=="Foil"],entrants.df[,1][entrants.df[,3]=="Foil"],entrants.df[,1][entrants.df[,4]=="Foil"])
fencerslist <- list(sabrefencers, epeefencers, foilfencers)
maxlength <- max(lengths(fencerslist))
fencerslist2 <- lapply(fencerslist, function(lst) c(lst, rep(NA, maxlength - length(lst))))
names(fencerslist2) <- c("Sabre", "Epee", "Foil")
fencerslist3 <- lapply(fencerslist2, unlist)
unigamesfencers <- as.data.frame(fencerslist3)
unigamesfencers <- unigamesfencers[order(unigamesfencers$Sabre, unigamesfencers$Foil, unigamesfencers$Epee),]
unigamesfencers <- sapply(unigamesfencers, as.character)
unigamesfencers[is.na(unigamesfencers)] <- ""
unigamesfencers

library(dplyr)
library(writexl)

entrants.df2 <- read.csv("NZ University Games Entry Form (Responses) - Form responses 1.csv", header = T)[,c(3,7:9,11:12)]
nathan <- which(entrants.df2=="Nathan Mcknight")
detroit <- which(entrants.df2=="Detroit James Evans")
qihang <- min(which(entrants.df2 == "Qihang Shi"))
entrants.df2 <- entrants.df2[-c(nathan,detroit,qihang),]
imms <- data.frame("Andrew Imms", "Sabre", "Epee", "Foil", "SJL", "Not affiliated")
names(imms) <- c("Full.name", "Main.weapon", "Second.weapon", "Third.weapon", "Fencing.Club", "Affiliation")
entrants.df2 <- rbind(entrants.df2,imms)

entrants.df2$Fencing.Club <- recode(entrants.df2$Fencing.Club, 
       "Auckland University Fencing " = "AUF", 
       "Auckland University Fencing Club " = "AUF", 
       "Auckland Swords Club" = "ASC", 
       "Auckland University Fencing" = "AUF", 
       "Auckland Uni Fencing Club" = "AUF", 
       "Auckland Swords" = "ASC", 
       "Asc" = "ASC", 
       "Auckland Swords " = "ASC", 
       "Auckland University Fencing Club" = "AUF", 
       "Auckland Sword Club" = "ASC", 
       "University of Auckland Fencing" = "AUF", 
       "UoA fencing" = "AUF", 
       "UOA fencing club" = "AUF", 
       "New Zealand Academy of Fencing/UoA Fencing Club" = "AUF/NZAF", 
       "Macleans College " = "Macleans College", 
       "Waikato Swords Club" = "Waikato Swords", 
       "Tuatahi" = "Tuatahi Fencing", 
       "Tuatahi Fencing " ="Tuatahi Fencing", 
       "Pulse Fencing, Avondale College Fencing" = "Pulse Fencing", 
       "Piwakawaka" = "Piwakawaka Fencing", 
       "piwakawaka" = "Piwakawaka Fencing", 
       "Piwakawaka Fencing club" = "Piwakawaka Fencing", 
       "Auckland sword fencing club" = "ASC", 
       "Auckland swords" = "ASC", 
       "AUF/Auckland Swords "="AUF/ASC", 
       "Waikato swords" = "Waikato Swords", 
       "Waikato swords Club" = "Waikato Swords", 
       "Sjl" = "SJL", "AUF / JF Fencing " = "AUF/JF Fencing", 
       "Claymore Swords " = "Claymore Swords", 
       "Nil currently " = "N/A")
print(entrants.df2)
write.csv(entrants.df2, "/home/bokchoi/Documents/Club stuff/AUF/Unigamesform/unigamesfencerslist/participantinfo.csv")
