setwd("/home/kelaktaa/dev/MOOCs/quantitative-investing/data/")

# Load data
spData <- read.csv(file = "SP500Data.csv")

# Get only close column of the data
price <- spData$Close
head(price, n=10)

gain <- price[1:(length(price) - 1)]

cost <- price[2:length(price)]

head(gain, n=10)
head(cost, n=10)

# return = (gain - cost)/cost
monthly.return <- (gain - cost)/cost
head(monthly.return, n=10)

# average monthly return
mean.monthly.return <- mean(monthly.return)
sprintf ("Monthly average return %f", mean.monthly.return)

sd.monthly.return <- sd(monthly.return)
sprintf ("Monthly return Standard deviation %f", sd.monthly.return)

##############################################################################
# Calculating means
# -- Geometric mean
number.month <- length(monthly.return)
geometric.mean.monthly.return <- prod(1 + monthly.return)^(1/number.month) -1

# -- Arithmetic mean
arithmetic.mean.monthly.return <- mean(monthly.return)

# Geometric variance
squared.geometric.mean.difference <- (monthly.return - geometric.mean.monthly.return) ^ 2
geometric.monthly.variance <- sum(squared.geometric.mean.difference)/number.month

# Geometric standard deviation
geometric.monthly.standarddeviation <- geometric.monthly.variance ^ 0.5

# Arithmetic variance
squared.arthimetic.mean.difference <- (monthly.return - arithmetic.mean.monthly.return) ^ 2
arithmetic.monthly.variance <- sum(squared.arthimetic.mean.difference) / number.month

# Artihmetic standard deviation
arithmetic.monthly.standarddeviation <- arithmetic.monthly.variance ^ 0.5
##############################################################################


# Assumption return of risk free asset
riskfree.return <- 0.0001
risk.free.standarddeviation <- 0

# 70% of the portfolio is risky asset
risky.weight <- 0.7

# Portfolio return = weighted return
portfolio.return <- risky.weight * geometric.mean.monthly.return + (1 - risky.weight) * riskfree.return
sprintf ("Portfolio return %f", portfolio.return)

# Portfolio variance [risk free assets variance = 0] (with arthimetic sd)
portfolio.variance <- risky.weight ^ 2  * sd.monthly.return ^ 2
sprintf ("Portfolio variance (arith sd) %f", portfolio.variance)

# Portfolio variance [risk free assets variance = 0] (with geometric sd)
portfolio.variance <- risky.weight ^ 2  * geometric.monthly.standarddeviation ^ 2
sprintf ("Portfolio variance (geo sd) %f", portfolio.variance)

# Portfolio risk (standard deviation)
portfolio.risk <- portfolio.variance ^ 0.5
sprintf ("Portfolio risk %f", portfolio.risk)

# Portfolio return data series
portfolio.return.series <- risky.weight * monthly.return + (1 - risky.weight) * riskfree.return
head(portfolio.return.series, n=10)

# Portfolio return mean
mean(portfolio.return.series)

# Portfolio return standard deviation
sd(portfolio.return.series)