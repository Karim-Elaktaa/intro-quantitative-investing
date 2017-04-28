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

standard.deviation.AAPL <- sd(monthly.return$AAPL)
sprintf("AAPL standard deviation %f", standard.deviation.AAPL)
standard.deviation.sp <- sd(monthly.return$SP500)
sprintf("SP500 standard deviation %f", standard.deviation.sp)

covariance.AAPL.sp <- cov(monthly.return$AAPL, monthly.return$SP500)
sprintf("AAPL & SP500 return covariance %f", covariance.AAPL.sp)

beta.AAPL <- covariance.AAPL.sp/standard.deviation.sp^2
sprintf("AAPL beta value %f", beta.AAPL)

# CAPM
# risk free rate 0.2%
rf <- 0.2
# market expectation 1%
market <- 1;
expected.return.AAPL <- rf + beta.AAPL * (market - rf)
sprintf("Expected return on AAPL %f", expected.return.AAPL)