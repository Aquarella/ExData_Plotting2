## Download and unzip the PM2.5 Emissions Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              exdata_data_NEI_data.zip)
unzip("exdata_data_NEI_data.zip")

##Read NEI data
NEI <- readRDS("summarySCC_PM25.rds")

##Transform "year" in NEI data frame into a factor variable
NEI <- transform(NEI, year = factor(year))

##Make data frame with total PM2.5 emissions for each year
total <- tapply(NEI$Emissions, NEI$year, sum)
total <- as.vector(total) ##This is a vector of total emissions by year
years <- levels(NEI$year)
years <- as.integer(years) ##This is a vector of years
dat <- as.data.frame(cbind(years, total))

##Create the plot
png(file = "plot1.png")
with(dat, plot(years, total, type = "b", xlab = "Year", ylab = expression("Total "*PM[2.5]*" emission (ton)")))
abline(lm(total ~ years, dat), col = "gold")
dev.off()