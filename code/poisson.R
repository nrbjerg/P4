library(purrr)

pmf <- function (lambda, k) {
  return (exp(-lambda) * (lambda ** k) / factorial(k))
}

simulate_poisson <- function(u, lambda = 1) {
  S <- 0
  k <- 0
  repeat {
    S. <- S + pmf(lambda, k)
    if (S < u && u <= S.) {
      return(k)
    }
    S <- S.
    k <- k + 1
  }
}

datapoints = 1000000
u <- runif(n = datapoints)
simulated_frequencies <- table(unlist(map(u, simulate_poisson))) / datapoints
# Convert to table of values & their frequency
#X11()
barplot(simulated_frequencies,
main="Simulations of poisson distrobution",
xlab = "k",
ylab = "simulated p(k)",
)

