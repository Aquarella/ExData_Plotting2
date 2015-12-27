## Download and unzip the PM2.5 Emissions Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
              exdata_data_NEI_data.zip)
unzip("exdata_data_NEI_data.zip")

##Read NEI data
NEI <- readRDS("summarySCC_PM25.rds")

##Transform "year" in NEI data frame into a factor variable
NEI <- transform(NEI, year = factor(year))

##Subset data for Baltimore City
Bal <- NEI[NEI$fips == "24510", ]

##Make data frame with total PM2.5 emissions in Baltimore City for each year
total_Bal <- tapply(Bal$Emissions, Bal$year, sum)
total_Bal <- as.vector(total_Bal) ##This is a vector of total emissions in Baltimore City by year
years <- levels(Bal$year)
years <- as.integer(years) ##This is a vector of years
dat <- as.data.frame(cbind(years, total_Bal))

##Create the plot
png(file = "plot2.png")
with(dat, plot(years, total_Bal, type = "b", xlab = "Year", ylab = expression("Baltimore City "*PM[2.5]*" emission (ton)")))
abline(lm(total_Bal ~ years, dat), col = "gold")
dev.off()