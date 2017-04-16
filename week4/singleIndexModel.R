setwd("/home/kelaktaa/dev/MOOCs/quantitative-investing/data/")

# Load data
spData <- read.csv(file = "SP500Data.csv")
aapl <- read.csv(file = "AAPL.csv")
tbill <- read.csv(file = "TBill.csv")


# Get price data from data
price <- data.frame(spData$Close, aapl$Close)
colnames(price) <- c("SP500", "AAPL")

# Rate of return & Annualized return
gain <- price[1:(dim(price)[1] - 1),]
cost <- price[2:(dim(price)[1]),]

monthly.return <- (gain - cost) / cost