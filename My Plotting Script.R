# My Plotting Script
# by William Dew

library(ggplot2)
library(reshape2)

#Load Data
rawdata<-read.csv("Plotdata.xls", header=TRUE)

#Convert the data to a simple X Y coordinates by Subject conditon
melted=melt(rawdata,id.vars="Subject",measure.vars=c("a","c","d","e","f","g","j","k"))

# Generate a ggplot and store it in the variable myPlot
myPlot<-ggplot(melted,aes(x=variable,y=value,col=Subject,group=Subject)) + 
    geom_point() + 
    geom_line() + 
    xlab("Sample") + 
    ylab("# Observed") + 
    ggtitle("Some Obervations I made in the Lab")

# Display plot in Plots panel
myPlot

# Save plot to PDF
ggsave(filename="MyPlot.pdf", plot=myPlot)