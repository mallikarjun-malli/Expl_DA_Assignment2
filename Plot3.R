library(ggplot2)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset for Balitmore
NEIofBalitmore <- subset(NEI,fips == "24510")

Emissions_Type_Year <- aggregate(NEIofBalitmore$Emissions,by=list(NEIofBalitmore$year,type=NEIofBalitmore$type), FUN=sum)

# plot the graph

ggplot(data=Emissions_Type_Year,aes(x=factor(Group.1), y = x,group=type,shape=type,color=type)) + geom_line(size=1) + geom_point(size=5) + xlab("years") + ylab("Total PM2.5 Emission (tons)") + ggtitle("Total PM2.5 emission per year by type (Balitmore)")

#save as png
dev.copy(png,'Plot3.png')
dev.off()