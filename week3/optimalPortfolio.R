setwd("/home/kelaktaa/dev/MOOCs/quantitative-investing/data/")

# Load data
spData <- read.csv(file = "SP500Data.csv")
nasdaq <- read.csv(file = "NASDAQ.csv")
spData <- read.csv(file = "SP500Data.csv")

# Get price data from data
price <- data.frame(spData$Close, nasdaq$Close)
colnames(price) <- c("SP500", "NASDAQ")
head(price, n=10)