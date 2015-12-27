## Download and unzip the PM2.5 Emissions Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              exdata_data_NEI_data.zip)
unzip("exdata_data_NEI_data.zip")

##Read NEI data
NEI <- readRDS("summarySCC_PM25.rds")

##Load ggplot2 library
library(ggplot2)

##Subset NEI data for motor vehicle sources of emission in Baltimore City
##"ON-ROAD" types of sources are considered to be motor vehicle sources
sub <- NEI[NEI$type == "ON-ROAD" & NEI$fips == "24510", ]

##Make data frame with total PM2.5 emissions from motor vehicle sources in Baltimore City for each year
agg <- aggregate(sub$Emissions, by = list(sub$year), FUN= sum)
names(agg) <- c("year", "Emissions")

##Create the plot
png(file = "plot5.png")
ggplot(agg, aes(year, Emissions)) + 
    geom_point() + 
    geom_line() + 
    geom_smooth(method = "lm", se = FALSE, lwd = 0.75, col = "gold") +
    xlab("Year") +
    ylab(expression(PM[2.5] *" emission (ton)")) +
    labs(title = "Emissions from motor vehicle sources in Baltimore City")
dev.off()