library(purrr)
library(eList)
library(plyr)
library(ggplot2)

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
  set.seed(2) # makes sure to that the first uniform random variables are always the same
  u <- runif(n = n)
  simulated_frequencies <- table(unlist(map(u, simulate_variable))) / n
  return(simulated_frequencies)
}

transform_dataset <- function(df, row_ids) {
  dfs <- List()
  for (i in seq(row_ids)) {
    row_id <- row_ids[i]
    row <- df[row_id, ]
    print(ncol(row))
    typ <- rep(c(row_id), each = ncol(df))
    k <- 0:(ncol(df) - 1)
    # Convert p(k) to column vector
    col <- t(row)
    colnames(col) <- c("p.k")
    dfs[[i]] <- data.frame(k = k, simulation.type = typ, p.k = col)
  }
  return(as.data.frame(do.call(rbind, dfs)))
}

ns <- c(1000, 2000, 5000)
results <- List(for (n in ns) simulate_poisson_pmf(n))

# Append zeroes to the back of the results vectors & create dataframe.
max.length <- max(sapply(results, length))
results <- lapply(results, function(v) {
  c(v, rep(0, max.length - length(v)))
})
df <- as.data.frame(do.call(rbind, results))
# Add true pmd, aswell as column and row names
print(max.length)
max.k <- max.length - 1
ks <- c(List(for (k in 0:max.k) k))
names(df) <- ks

true.pmf <- data.frame(List(for (k in ks) poisson_pmf(k)))

names(true.pmf) <- ks
df <- rbind(df, true.pmf)[, c(1, 2, 3, 4)] # Only get the first 4 columns
row_ids <- append(ns, c("true pmf"))
rownames(df) <- row_ids
# Transform dataframe for plotting
df <- transform_dataset(df, row_ids)
print(df)

theme_set(
  theme(legend.position = "top")
)

ggplot(df, aes(x = k, y = p.k, fill = simulation.type)) +
  geom_col(position = "dodge")
