options(scipen=999)

library(sqldf)
library(ggplot2)

setwd("/Users/richardcoleman/Git/Exploratory-Data-Analysis/Course Project 2/")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- merge(NEI,SCC,by="SCC",all.x=TRUE)

#############plot
dfTemp <- sqldf("
select Pollutant
  ,type
  ,year
  ,sum(Emissions) as total_emissions
from df
where fips = 24510
  and year between 1999 and 2008
group by 1,2,3
                ")

png("plot3.png",height=4, width=6, units="in", res=400)

ggplot(data=dfTemp,aes(x=year,y=total_emissions,color=type)) + 
  geom_line(size=1,alpha=.5) + 
  labs(x="Year",y="Total Emissions",title="Total Emissions in Baltimore City by Emission Type",color="Emission Type")

dev.off()
