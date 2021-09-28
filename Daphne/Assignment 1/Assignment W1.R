# Assignment week 1 - Markup Languages and Reproducible Programming in Statistics
# Daphne Weemering (3239480)

#-------------------------------------------------------------------------------
library(plyr)
library(tidyverse)

# Set a seed for reproducibility
set.seed(3239480)

# Create storage for the samples
sam <- replicate(100, rnorm(20000, 0, 1))

# Calculate for each sample the: 1) absolute bias, 2) standard error, 3) lower bound
# of 95% confidence interval, 4) upper bound of 95% confidence interval
statistics <- function(x){
  mn <- mean(x)
  abbias <- abs(mn - 0)
  se <- sd(x) / sqrt(length(x))
  df <- length(x) - 1
  diff <- qt(0.975, df) * se
  lowerb <- mn - diff
  upperb <- mn + diff
  return(c(mn, abbias, se, lowerb, upperb))
}

res <- apply(sam, 2, statistics) # Apply the function to all the columns
res <- as.data.frame(t(res)) # Change rows and columns

# Add column names in order to see which variables is what
colnames(res) <- c("average", "absolute_bias", "SE", "lower_bound", "upper_bound")

# Add a logical variable that indicates whether the mean is included in the interval
res <- mutate(res, coverage = lower_bound < 0 & 0 < upper_bound)

# See the column means 
colMeans(res)

# Make a plot that demonstrates that “A replication of the procedure that generates 
# a 95% confidence interval that is centered around the sample mean would cover 
# the population value at least 95 out of 100 times”
lims <- aes(ymax = res$upper_bound, ymin = res$lower_bound)
ggplot(res, aes(y = average, x = 1:100, colour = coverage)) +
  geom_hline(aes(yintercept = 0), color = 'dark grey', size = 2) +
  geom_pointrange(lims) +
  xlab('Simulations 1-100') +
  ylab('Means and 95% confidence intervals')

# A table containing all simulated samples for which the resulting confidence 
# interval does not contain the population value
nopopval <- res[which(res$coverage == F), ]






