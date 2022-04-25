rona <- dpois(seq.int(0, 32), 1)

branchproc <- function(distr, max_gens=100, limit=1000000) {
    Z <- vector("integer", max_gens);
    Z[1] <- 1634;
    last <- max_gens;
    for (i in 2:max_gens) {
        if (Z[i - 1] == 0 || Z[i - 1] >= limit) {
            last <- i - 1;
            break
        }
        else Z[i] <- sum(sample(seq.int(0, length(distr)-1), Z[i-1], TRUE, distr))
    }
    c(Z[1:last])
}

is_extinct <- function(v) {
    v[length(v)] == 0
}