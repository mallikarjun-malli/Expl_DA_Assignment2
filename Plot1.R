# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum emissions by year
EmissionsByYear <- aggregate(Emissions ~ year,FUN=sum,data=NEI)

# plot the graph
opt <- options("scipen" = 20)
barplot(as.numeric(EmissionsByYear$Emissions),
        names = c("1999", "2002", "2005", "2008"),
        main = "Total PM2.5 emission by year",
        ylab="Total PM2.5 Emission (tons)",
        xlab="Years")
#save as png
dev.copy(png,'Plot1.png')
dev.off()