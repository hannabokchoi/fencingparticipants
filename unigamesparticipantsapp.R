#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(DT)

entrants.df <- read.csv("NZ University Games Entry Form (Responses) - Form responses 1.csv")[,c(3,7:9)]
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

    shinyApp(
        ui <- basicPage(
            title = "Unigames Participants List",
            DT::dataTableOutput('table')
        ),
        server <- function(input, output) {
            output$table <- DT::renderDataTable(
                DT::datatable(unigamesfencers, options = list(pageLength = 50))
            )
        }
    )

# Run the application 
shinyApp(ui, server)
