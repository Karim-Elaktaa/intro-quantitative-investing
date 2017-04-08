setwd("/home/kelaktaa/dev/MOOCs/quantitative-investing/data/")

# Read data
SP500 <- read.csv(file = "SP500Data.csv")

SP500

colnames(SP500)

price <- SP500$Close
price2 <- SP500[,5]

selectedData <- SP500[5, 3]
selectedData
