setwd("/home/kelaktaa/dev/MOOCs/quantitative-investing/data/")

# Load data
spData <- read.csv(file = "SP500Data.csv")

# Get only close column of the data
price <- SP500$Close
head(price, n=10)

gain <- price[1:(length(price) - 1)]

cost <- price[2:length(price)]

head(gain, n=10)
head(cost, n=10)

# return = (gain - cost)/cost
monthly.return <- (gain - cost)/cost
head(monthly.return, n=10)

# estimated probability of scenarios
# scenarios   = excellent | good | poor   | terrible
# probability = 0.3       | 0.2  | 0.4    | 0.1
# return      = 0.2       | 0.1  | -0.05  | -0.4

probability.status <- c(0.3, 0.2, 0.4, 0.1)
expecteed.return.status <- c(0.2, 0.1, -0.05, -0.4)

expected.return.with.probability <- probability.status * expecteed.return.status

# the annual expected return is the sum of the return scenario by probability
expected.return <- sum(expected.return.with.probability)
sprintf ("Annual expected return %f", expected.return)

# Monthly return
monthly.expected.return <- ((1 + expected.return)^(1/12) -1)
sprintf ("Monthly expected return %f", monthly.expected.return)

# Arithmetic Variance
var(monthly.return)

# Standard Deviation
sd(monthly.return)

# Calculating means
# -- Geometric mean
number.month <- length(monthly.return)
geometric.mean.monthly.return <- prod(1 + monthly.return)^(1/number.month) -1
sprintf ("Monthly geometric mean %f", geometric.mean.monthly.return)

# -- Arithmetic mean
arithmetic.mean.monthly.return <- mean(monthly.return)
sprintf ("Monthly arithmetic mean %f", geometric.mean.monthly.return)

# Geometric variance
squared.geometric.mean.difference <- (monthly.return - geometric.mean.monthly.return) ^ 2
geometric.monthly.variance <- sum(squared.geometric.mean.difference)/number.month
sprintf ("Monthly geometric variance %f", geometric.monthly.variance)

# Geometric standard deviation
geometric.monthly.standarddeviation <- geometric.monthly.variance ^ 0.5
sprintf ("Monthly geometric standard deviation %f", geometric.monthly.standarddeviation)

# Arithmetic variance
squared.arthimetic.mean.difference <- (monthly.return - arithmetic.mean.monthly.return) ^ 2
arithmetic.monthly.variance <- sum(squared.arthimetic.mean.difference) / number.month
sprintf ("Monthly arithmetic variance %f", arithmetic.monthly.variance)

# Artihmetic standard deviation
arithmetic.monthly.standarddeviation <- arithmetic.monthly.variance ^ 0.5
sprintf ("Monthly arithmetic standard deviation %f", arithmetic.monthly.standarddeviation)
