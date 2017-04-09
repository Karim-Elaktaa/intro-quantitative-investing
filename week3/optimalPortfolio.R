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
