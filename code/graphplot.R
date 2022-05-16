library(ggplot2)
library(tidyr)

results <- read.csv(file = "code/data/extinctionresults4.csv")
colnames(results)[9:14] <- c("λ = 0.7", "λ = 0.9", "λ = 0.99", "λ = 0.999", "λ = 1", "λ = 1.001")
print(summary(results[,9:14]))
#results[, 3:8] %>%
#    pivot_longer(., cols = colnames(results)[3:8], names_to = "test", values_to = "n") %>%
#    ggplot(aes(x = n, colour = test)) + geom_density(adjust = 2) +
#    labs(title = "Generationer før spredning stopper", subtitle="Z_0 = 157", x = "Generationer", y="Tæthed", colour = "Kontakttal") +
#    theme_minimal() +
#    scale_colour_manual(values = hcl(c(15, 45, 75, 165, 255, 315), 100, 40)) +
#    scale_x_log10(labels = function(x) format(x, scientific = FALSE), breaks=c(10^0, 10^1, 10^2, 10^3, 10^4, 10^5, 10^6))
#ggsave("code/graph.png")