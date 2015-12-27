## Download and unzip the PM2.5 Emissions Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              exdata_data_NEI_data.zip)
unzip("exdata_data_NEI_data.zip")

##Read NEI data
NEI <- readRDS("summarySCC_PM25.rds")

##Load ggplot2 library
library(ggplot2)

##Subset NEI data for motor vehicle sources of emission in Baltimore City and LA
##"ON-ROAD" types of sources are considered to be motor vehicle sources
sub <- NEI[NEI$type == "ON-ROAD" & (NEI$fips == "24510" | NEI$fips == "06037"), ]

##Make data frame with total PM2.5 emissions from motor vehicle sources in Baltimore City and LA for each year
agg <- aggregate(sub$Emissions, by = list(sub$year, sub$fips), FUN= sum)
names(agg) <- c("year", "fips", "Emissions")

##Replace fips values with city names
agg$fips[agg$fips == "24510"] <- "Baltimore City"
agg$fips[agg$fips == "06037"] <- "LA"

##Create the plot
png(file = "plot6.png")
ggplot(agg, aes(year, Emissions)) + 
    geom_point() + 
    geom_line() + 
    facet_grid(.~fips) + 
    geom_smooth(method = "lm", se = FALSE, lwd = 0.75, col = "gold") +
    xlab("Year") +
    ylab(expression(PM[2.5] *" emission (ton)")) +
    labs(title = "Emissions from motor vehicle sources in Baltimore City and LA")
dev.off()