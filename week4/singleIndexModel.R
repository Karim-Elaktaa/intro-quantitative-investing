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

# Annualize T-Bill
monthly.tbill <- (1 + tbill$X3MTbill) ^ (1/12) -1

# Monthly risk premium
monthly.risk.premium <- data.frame(monthly.return$SP500 - monthly.tbill,
                                   monthly.return$AAPL - monthly.tbill)
colnames(monthly.risk.premium) <- c("SP500 RP", "AAPL RP")
head(monthly.risk.premium, n=4)

plot(monthly.risk.premium, main="Risk Premium of SP500 and Apple")