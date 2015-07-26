options(scipen=999)

library(sqldf)
library(ggplot2)

setwd("/Users/richardcoleman/Git/Exploratory-Data-Analysis/Course Project 2/")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- merge(NEI,SCC,by="SCC",all.x=TRUE)

#############plot 1
dfTemp <- sqldf("
select Pollutant
  ,year
  ,sum(Emissions) as total_emissions
from df
where year in (1999,2002,2005,2008)
group by 1,2
                ")

png("plot1.png",height=4, width=8, units="in", res=400)

plot(dfTemp$year,dfTemp$total_emissions,type="o",xlab="Year",ylab="Total Emissions ",las=2)
title(main="Total Emissions in United States")

dev.off()
