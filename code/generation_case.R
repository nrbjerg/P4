source("code/branchproc.R")

add_vectors <- function(v, u) {
  # Add vectors of different lengths, however v must be of greater lenght than u.
  result <- vector("integer", length(v))
  for(i in 1:length(v)) {
    if (i <= length(u)) {
      result[i] <- v[i] + u[i]
    } else {
      result[i] <- v[i]
    }
  }
  result
}

compute_empirical_mean_of_population <- function (mu, n, number_of_generations=100, Z0=1) {
  Z <- vector("integer", number_of_generations);
  for (k in 1:n) {
    Z <- add_vectors(Z, branchproc(mu, max_gens=number_of_generations, firstgensize=Z0));
  }
  Z / n
}

compute_mean_of_population <- function (mu, number_of_generations=100, Z0 = 1) {
  mean <- vector("numeric", number_of_generations)
  for (k in 0:(number_of_generations - 1)) {
    # NOTE: here we have Z_0 different GW processes, with mean mu^k
    mean[k + 1] <- Z0 * mu ** k
  }
  mean
}

plot_means <- function (mu, n, number_of_generations = 14, Z0 = 1) {
  empirical_mean <- compute_empirical_mean_of_population(mu, n, number_of_generations = number_of_generations, Z0 = Z0)
  mean <- compute_mean_of_population(mu, number_of_generations = number_of_generations, Z0 = Z0)

  # creating a dataframe for the data.
  empirical_mean_df <- data.frame(Graf=rep(c("Målt generationsstørrelse"),times=number_of_generations), generation=c(1:number_of_generations), value=empirical_mean)
  mean_df <- data.frame(Graf=rep(c("Teoretisk middelværdi"),times=number_of_generations), generation=c(1:number_of_generations), value=mean)
  df <- rbind(empirical_mean_df, mean_df)

  ggplot(data=df, aes(x=generation, y=value, group=Graf)) +
    geom_line(aes(linetype =Graf))+
    geom_point() +
    labs(title = "Antal individer per generation",
         x = "Generation",
         y = "Antal individer") +
    theme_minimal() +
    theme(legend.position = "bottom")
  ggsave(sprintf("code/generation_case[%s].png", mu))
}

plot_means(0.7, 1, Z0=1593)
plot_means(1.3, 1, Z0=157)
