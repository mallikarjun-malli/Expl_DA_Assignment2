library(ggplot2)
library(plyr)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset for Balitmore
NEIofBalitmore <- subset(NEI,fips == "24510")
NEIofLA <- subset(NEI,fips == "06037")

# subsetting Motor Veichle data
MotorVeichleSCC <- subset(SCC, grepl("- On-Road", as.character(EI.Sector)))
MotorVeichleSCCValues <- MotorVeichleSCC$SCC
NEI_Baltmore_MV <- subset(NEIofBalitmore,SCC %in% MotorVeichleSCCValues)
NEI_LA_MV <- subset(NEIofLA,SCC %in% MotorVeichleSCCValues)


#sum MV emmisions per year

MV_Emmisions_year_Baltmore <- aggregate(Emissions ~ year,FUN=sum,data=NEI_Baltmore_MV)
MV_Emmisions_year_LA <- aggregate(Emissions ~ year,FUN=sum,data=NEI_LA_MV)

MV_Emmisions_year_Baltmore <- rename(MV_Emmisions_year_Baltmore,c("Emissions"="Emissions_Baltmore"))
MV_Emmisions_year_LA <- rename(MV_Emmisions_year_LA,c("Emissions"="Emissions_LA"))
MV_Emissions_Baltmore_LA <- merge(MV_Emmisions_year_Baltmore,MV_Emmisions_year_LA)

melted_emissions <- melt(MV_Emissions_Baltmore_LA,id.vars="year")

# plot the graph

ggplot(data=melted_emissions,aes(x=factor(year), y = value,group=variable,shape=variable,color=variable)) + geom_line(size=1) + geom_point(size=5) + xlab("years") + ylab("Total PM2.5 Emission (tons)") + ggtitle("Total PM2.5 emission per year by Motor Veichle (Balitmore vs LA)")

#save as png

dev.copy(png,'Plot6.png')
dev.off()