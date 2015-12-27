## Download and unzip the PM2.5 Emissions Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              exdata_data_NEI_data.zip)
unzip("exdata_data_NEI_data.zip")

##Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Load ggplot2 library
library(ggplot2)

##Select data for coal combustion-related sources
coal_comb.SCC <- SCC$SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE) & 
                         grepl("comb", SCC$Short.Name, ignore.case=TRUE)]
sub <- NEI[NEI$SCC %in% coal_comb.SCC, ]

##Make data frame with total PM2.5 emissions from coal combustion-related sources for each year
agg <- aggregate(sub$Emissions, by = list(sub$year), FUN= sum)
names(agg) <- c("year", "Emissions")

##Create the plot
png(file = "plot4.png")
ggplot(agg, aes(year, Emissions)) + 
      geom_point() + 
      geom_line() + 
      geom_smooth(method = "lm", se = FALSE, lwd = 0.75, col = "gold") +
      xlab("Year") +
      ylab(expression(PM[2.5] *" emission (ton)")) +
      labs(title = "Emissions from coal combustion-related sources in USA")
dev.off()