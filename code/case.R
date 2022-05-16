source("code/branchproc.R")
datapoints <- 10000

cases <- read.csv(file = "code/data/cases2.csv")
data <- data.frame(matrix(nrow = datapoints, ncol = nrow(cases)))
for (i in seq_len(nrow(cases))) {
    mu <- cases[i, ]$kontakttal
    smittet <- cases[i, ]$smittet
    result <- extinctdist(mu, max_gens=10^6, runs = datapoints, firstgensize = smittet)
    data[, i] <- result
}
colnames(data) <- cases[, 1]
print("Done!")
write.csv(data,'code/data/results.csv')