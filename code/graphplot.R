library(ggplot2)
library(tidyr)

results <- read.csv(file = "code/data/extinctionresults3.csv")
colnames(results)[2:7] <- c("μ = 0.6", "μ = 0.75", "μ = 0.9", "μ = 0.999", "μ = 1", "μ = 1.001")
print(var(results[,2:7]))
results[, 2:7] %>%
    pivot_longer(., cols = colnames(results)[2:7], names_to = "test", values_to = "n") %>%
    ggplot(aes(x = n, colour = test)) + geom_density(adjust = 2) +
    labs(title = "Generationer før spredning stopper", subtitle="Z_0 = 157", x = "Generationer", y="Tæthed", colour = "Middelværdi") +
    theme_minimal() +
    scale_colour_manual(values = hcl(c(15, 45, 75, 165, 255, 315), 100, 40)) +
    scale_x_log10(labels = function(x) format(x, scientific = FALSE), breaks=c(10^0, 10^1, 10^2, 10^3, 10^4, 10^5, 10^6))
ggsave("code/graph.png")