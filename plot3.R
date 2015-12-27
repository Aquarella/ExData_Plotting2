## Download and unzip the PM2.5 Emissions Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              exdata_data_NEI_data.zip)
unzip("exdata_data_NEI_data.zip")

##Read NEI data
NEI <- readRDS("summarySCC_PM25.rds")

##Load ggplot2 library
library(ggplot2)

##Subset data for Baltimore City
Bal <- NEI[NEI$fips == "24510", ]

##Make data frame with total PM2.5 emissions in Baltimore City for each year and source type

agg <- aggregate(Bal$Emissions, by = list(Bal$year, Bal$type), FUN = sum)
names(agg) <- c("year", "type", "Emissions")

##Create the plot
png(file = "plot3.png")
ggplot(agg, aes(year, Emissions)) + 
        geom_point() + 
        geom_line() + 
        facet_grid(.~type) + 
        geom_smooth(method = "lm", se = FALSE, lwd = 0.75, col = "gold") + 
        xlab("Year") + 
        ylab(expression(PM[2.5] *" emission (ton)")) +
        labs(title = "Emissions by Source for Baltimore City")
dev.off()