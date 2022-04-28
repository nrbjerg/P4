library(ggplot2)

ronamu <- 1
ronafirst <- 1634

branchproc <- function(mu, max_gens=100, limit=1000000, firstgensize=1) {
    Z <- vector("integer", max_gens);
    Z[1] <- firstgensize;
    last <- max_gens;
    for (i in 2:max_gens) {
        if (Z[i - 1] == 0 || Z[i - 1] >= limit) {
            last <- i - 1;
            break
        }
        else Z[i] <- rpois(1, Z[i-1]*mu)
    }
    Z[1:last]
}

extinctproc <- function(mu, max_gens=10000, limit=1000000, firstgensize=1) {
    repeat {
        Z <- firstgensize
        for (j in seq_len(max_gens)) {
            Z <- rpois(1, Z*mu);
            if (Z == 0) return(log(j));
            if (Z >= limit) break
        }
    }
}

extinctdist <- function(mu, max_gens=10000, runs=100, limit=1000000, firstgensize=1) {
    out <- vector("double", runs);
    for (i in seq_along(out)) {
        out[i] <- extinctproc(mu, max_gens, limit, firstgensize)
    }
    out
}