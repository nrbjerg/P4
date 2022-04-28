library(purrr)
library(eList)
library(plyr)
# library(tidyverse)

poisson_pmf <- function(k) {
  # Here lambda = 1
  return(exp(-1) / factorial(k))
}

simulate_variable <- function(u, pmf = poisson_pmf) {
  # Simulates a discrete stochastic variable with the given pmf
  S <- 0
  k <- 0
  repeat {
    S. <- S + pmf(k)
    if (S < u && u <= S.) {
      return(k)
    }
    S <- S.
    k <- k + 1
  }
}

simulate_poisson_pmf <- function(n) {
  # Simulates a sequence and creates a barplot
  u <- runif(n = n)
  simulated_frequencies <- table(unlist(map(u, simulate_variable))) / n
  return(simulated_frequencies)
}

ns <- c(100, 1000, 5000) 
results <- List(for(n in ns) simulate_poisson_pmf(n))

# Append zeroes to the back of the results vectors & create dataframe.
max.length <- max(sapply(results, length))
results <- lapply(results, function(v) {c(v, rep(0, max.length - length(v)))})
df <- as.data.frame(do.call(rbind, results))
rownames(df) <- ns # Make the ns the rownames of the dataframe
print(df)
# Convert to table of values & their frequency
# X11()
# barplot(simulated_frequencies,
#  main = "Simulations of poisson distrobution",
#  xlab = "k",
#  ylab = "simulated p(k)",
# )
