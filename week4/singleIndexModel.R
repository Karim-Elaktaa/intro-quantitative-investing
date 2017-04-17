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
colnames(monthly.risk.premium) <- c("SP500", "AAPL")
head(monthly.risk.premium, n=4)

# Linear Regression
# AAPL = dependent variable
# SP500 = independent variable
index.model.aapl <- lm(AAPL ~ SP500, data = monthly.risk.premium)
# beta = 1.243695 [beta > 1 => high beta stock || beta < 1 => low beta stock]
# alpha = 0.008759
summary(index.model.aapl)

plot(monthly.risk.premium, main="Risk Premium of SP500 and Apple Regression")
abline(index.model.aapl)