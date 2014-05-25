library(ggplot2)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset for Balitmore
NEIofBalitmore <- subset(NEI,fips == "24510")

# subsetting Motor Veichle data
MotorVeichleSCC <- subset(SCC, grepl("- On-Road", as.character(EI.Sector)))
MotorVeichleSCCValues <- MotorVeichleSCC$SCC
NEI_Baltmore_MV <- subset(NEIofBalitmore,SCC %in% MotorVeichleSCCValues)

#sum MV emmisions per year

MV_Emmisions_year <- aggregate(Emissions ~ year,FUN=sum,data=NEI_Baltmore_MV)

# plot the graph

qplot(x=factor(year),y=Emissions, data=MV_Emmisions_year,geom="bar",stat="identity") + xlab("years") + ylab("Total PM2.5 Emission (tons)") + ggtitle("Total Emissions from Motor Veichles by year in Baltimore City")

#save as png

dev.copy(png,'Plot5.png')
dev.off()