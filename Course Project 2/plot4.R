options(scipen=999)

library(sqldf)
library(ggplot2)

setwd("/Users/richardcoleman/Git/Exploratory-Data-Analysis/Course Project 2/")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- merge(NEI,SCC,by="SCC",all.x=TRUE)

#############plot
dfTemp <- df[grep("coal",df$Short.Name),]

dfTemp <- sqldf("
select year
  ,sum(Emissions) as total_emissions
from dfTemp
where year between 1999 and 2008
group by 1
")

png("plot4.png",height=4, width=6, units="in", res=400)

ggplot(data=dfTemp,aes(x=year,y=total_emissions)) + 
  geom_line(size=1,alpha=.5) + 
  labs(x="Year",y="Total Emissions",title="Total Emissions in United States (Coal Powered Emissions)")

dev.off()
