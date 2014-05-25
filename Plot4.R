library(ggplot2)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting coal data
coalSCC <- subset(SCC, grepl("- Coal", as.character(EI.Sector)))
coalSCCValues <- coalSCC$SCC
NEIForCoal <- subset(NEI,SCC %in% coalSCCValues)

#sum coal emmisions per year

coal_Emmisions_year <- aggregate(Emissions ~ year,FUN=sum,data=NEIForCoal)

# plot the graph

qplot(x=factor(year),y=Emissions, data=coal_Emmisions_year,geom="bar",stat="identity") + xlab("years") + ylab("Total PM2.5 Emission (tons)") + ggtitle("Total Emissions from coal combustion-related sources by year")

#save as png

dev.copy(png,'Plot4.png')
dev.off()