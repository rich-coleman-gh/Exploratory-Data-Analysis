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


dfTemp1 <- sqldf("
select year
  ,fips
  ,sum(Emissions) as total_emissions
from df
where fips = 06037 or fips = 24510 and type = 'ON-ROAD'
group by 1,2
")

png("plot6.png",height=4, width=6, units="in", res=400)

ggplot() + 
  geom_line(data=dfTemp1,aes(x=year,y=total_emissions,color="Los Angeles"),size=1,alpha=.5) + 
  geom_line(data=dfTemp2,aes(x=year,y=total_emissions,color="Baltimore City"),size=1,alpha=.5) + 
  labs(x="Year",y="Total Emissions",title="Total Emissions in Baltimore City vs Los Angeles for Motor Vehicles")

dev.off()
