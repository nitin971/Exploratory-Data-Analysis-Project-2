## Question 5 -> How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## get data
## Question 6-> Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# read national emission inventory data (NEI)


fileNEI = "summarySCC_PM25.rds"

NEI <- readRDS(fileNEI)

# read source classification codes (SCC)


fileSCC = "Source_Classification_Code.rds"

SCC <- readRDS(fileSCC)


# get Baltimore and Los Angeles NEI data

NEIBaLa <- subset(NEI, fips == "24510" | fips == "06037")

# get motor vehicle SCC

vehicleSource <- SCC[grepl("Vehicle", SCC$EI.Sector),]

# select baltimore data based on vehicle sources

vehicleBaLa <- subset(NEIBaLa, NEIBaLa$SCC %in% vehicleSource$SCC)

# assign the city name, based on fips code

vehicleBaLa$city <- rep(NA, nrow(vehicleBaLa))
vehicleBaLa[vehicleBaLa$fips == "06037", ][, "city"] <- "Los Angeles County"
vehicleBaLa[vehicleBaLa$fips == "24510", ][, "city"] <- "Baltimore City"


# make plotdata
plotdata <- aggregate(vehicleBaLa[c("Emissions")], 
                      list(city = vehicleBaLa$city, 
                           year = vehicleBaLa$year), sum)

## create file
png('plot6.png', width=480, height=480)

## plot data
p <- ggplot(plotdata, aes(x=year, y=Emissions, colour=city)) +
    # fade out the points so you will see the line
    geom_point(alpha=0.1) +
    # use loess as there are many datapoints
    geom_smooth(method="loess") +
    ggtitle("PM2.5 Emissions in Baltimore and Los Angeles for Motor Vehicles")
print(p)

## close device
dev.off()
