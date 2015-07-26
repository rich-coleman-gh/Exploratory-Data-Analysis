options(scipen=999)

library(sqldf)
library(ggplot2)

setwd("/Users/richardcoleman/Git/Exploratory-Data-Analysis/Course Project 2/")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- merge(NEI,SCC,by="SCC",all.x=TRUE)

#############plot
names(df)[names(df) == 'Short.Name'] <- "short_name"
names(df)[names(df) == 'SCC.Level.One'] <- "scc_level_one"
names(df)[names(df) == 'SCC.Level.Two'] <- "scc_level_two"
names(df)[names(df) == 'EI.Sector'] <- "ei_sector"


dfTemp <- sqldf("
select year
  ,ei_sector as type
  ,sum(Emissions) as total_emissions
from df
where year between 1999 and 2008
  and type = 'ON-ROAD' and fips = 24510
group by 1,2
")

png("plot5.png", units="in", res=400)

ggplot(data=dfTemp,aes(x=year,y=total_emissions,color=type)) + 
  geom_line(size=1,alpha=.5) + 
  labs(x="Year",y="Total Emissions",title="Total Emissions in Baltimore City for Motor Vehicles")

dev.off()
