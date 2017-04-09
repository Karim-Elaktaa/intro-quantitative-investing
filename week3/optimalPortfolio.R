setwd("/home/kelaktaa/dev/MOOCs/quantitative-investing/data/")

# Load data
spData <- read.csv(file = "SP500Data.csv")
nasdaq <- read.csv(file = "NASDAQ.csv")
spData <- read.csv(file = "SP500Data.csv")

# Get price data from data
price <- data.frame(spData$Close, nasdaq$Close)
colnames(price) <- c("SP500", "NASDAQ")

# Rate of return & Annualized return
gain <- price[1:(dim(price)[1] - 1),]
cost <- price[2:(dim(price)[1]),]

monthly.return <- (gain - cost) / cost

number.month <- dim(monthly.return)[1]
sprintf("Number of months %d", number.month)

# Return (Mean)
spData.monthly.return <- prod(1 + monthly.return$SP500) ^ (1/number.month) - 1
sprintf("SP500 geometric average monthly return %f -- %f%%", spData.monthly.return, spData.monthly.return * 100)

nasdaq.monthly.return <- prod(1 + monthly.return$NASDAQ) ^ (1/number.month) - 1
sprintf("NASDAQ geometric average monthly return %f -- %f%%", nasdaq.monthly.return, nasdaq.monthly.return * 100)

# Risk (Standard deviation)
spData.monthly.sd <- sd(monthly.return$SP500)
spData.monthly.geosd <- (sum((monthly.return$SP500 - spData.monthly.return)^2)/number.month)^0.5
sprintf("SP500 arithmetic Standard deviation %f", spData.monthly.sd)
sprintf("SP500 geometric Standard deviation %f", spData.monthly.geosd)

nasdaq.monthly.sd <- sd(monthly.return$NASDAQ)
nasdaq.monthly.geosd <- (sum((monthly.return$NASDAQ - nasdaq.monthly.return)^2)/number.month)^0.5
sprintf("NASDAQ arithmetic Standard deviation %f", nasdaq.monthly.sd)
sprintf("NASDAQ geometric Standard deviation %f", nasdaq.monthly.geosd)

# Covariance
sp.nasdaq.covariance <- cov(monthly.return$SP500, monthly.return$NASDAQ)
sprintf("SP500 & NASDAQ covariance %f", sp.nasdaq.covariance)

# Correlation
sp.nasdaq.correlation <- cor(monthly.return$SP500, monthly.return$NASDAQ)
sprintf("SP500 & NASDAQ correlation %f", sp.nasdaq.correlation)

# Unoptimized portfolio
w <- 0.6 # weight
# Portfolio return
portfolio.return <- w * spData.monthly.return + (1 - w) * nasdaq.monthly.return
sprintf("Portfolio return %f -- %f%%", portfolio.return, portfolio.return * 100)
# Portfolio risk
portfolio.risk <- sqrt(w ^ 2 * spData.monthly.sd ^ 2 + (1 - w)^2 * nasdaq.monthly.sd ^ 2 + 2 * w * (1 - w) * sp.nasdaq.covariance)
sprintf("Portfolio risk %f -- %f%%", portfolio.risk, portfolio.risk * 100)

# Finding the optimal portfolio
w <- seq(0, 1, 0.1)

for (i in 1:length(w)) {
# Compute return
   this.port.return <- w[i] * spData.monthly.return + (1 - w[i]) * nasdaq.monthly.return
# Compute risk
   this.port.risk <- sqrt(w[i]^2 * spData.monthly.sd^2 + (1-w[i])^2 * nasdaq.monthly.sd^2 + 2*w[i]*(1-w[i])*sp.nasdaq.covariance)
# Bind the result   
   this.port.stat <- cbind(w[i], 1-w[i], this.port.return, this.port.risk)
   
   if (i == 1) {
      portfolio.result <- this.port.stat
   } else {
# add the current result to all results
      portfolio.result <- rbind(portfolio.result, this.port.stat)   
   }
}
portfolio.result