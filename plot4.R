## Question 4 -> Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## get data

# read national emission inventory data (NEI)

fileNEI = "summarySCC_PM25.rds"

NEI <- readRDS(fileNEI)

# read source classification codes (SCC)

fileSCC = "Source_Classification_Code.rds"

SCC <- readRDS(fileSCC)

##  plotdata:  coal combustion-related sources emission for USA 

## agregated per year

coalSource <- SCC[grepl("[Cc]oal", SCC$Short.Name),]

# select NEI data based on coal sources

coalNEI <- subset(NEI, NEI$SCC %in% coalSource$SCC)

# De-duplicate the data?

#coalNEI <- coalNEI[!duplicated(coalNEI),]

plotdata <- aggregate(coalNEI[c("Emissions")], 
                      list(year = coalNEI$year), sum)

## create file
png('plot4.png', width=480, height=480)

## plot data
p <- ggplot(plotdata, aes(x=year, y=Emissions, colour=type)) +
    # fade out the points so you will see the line
    geom_point(alpha=0.1) +
    # use loess as there are many datapoints
    geom_smooth(method="loess") +
    ggtitle("Total coal sourced Emission in the US 1999-2008")
print(p)

## close device
dev.off()
