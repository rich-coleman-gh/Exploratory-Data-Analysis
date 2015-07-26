options(scipen=999)

library(sqldf)
library(ggplot2)

setwd("/Users/richardcoleman/Git/Exploratory-Data-Analysis/Course Project 2/")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- merge(NEI,SCC,by="SCC",all.x=TRUE)

#df <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

#############plot 2
dfTemp <- sqldf("
select Pollutant
  ,year
  ,sum(Emissions) as total_emissions
from df
where fips = 24510
  and year between 1999 and 2008
group by 1,2
                ")

png("plot2.png",height=4, width=6, units="in", res=400)

plot(dfTemp$year,dfTemp$total_emissions,type="o",xlab="Year",ylab="Total Emissions ",las=2);
title(main="Total Emissions in Baltimore City");

dev.off()
