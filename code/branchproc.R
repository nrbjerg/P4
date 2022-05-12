library(ggplot2)

ronamu <- 1
ronafirst <- 1634

branchproc <- function(mu, max_gens=100, firstgensize=1) {
    Z <- vector("integer", max_gens);
    Z[1] <- firstgensize;
    last <- max_gens;
    for (i in 2:max_gens) {
        if (Z[i - 1] == 0 || Z[i - 1] >= 10^9) {
            last <- i - 1;
            break
        }
        else Z[i] <- rpois(1, Z[i-1]*mu)
    }
    Z[1:last]
}

extinctproc <- function(mu, max_gens=10000, firstgensize=1) {
    fails <- c(0, 0)
    repeat {
        Z <- firstgensize
        for (j in seq_len(max_gens)) {
            Z <- rpois(1, Z*mu);
            if (Z == 0) return(c(j, fails));
            if (Z >= 10^9) break
        }
        if (Z >= 10^9) {
            fails[1] <- fails[1] + 1
        } else {
            fails[2] <- fails[2] + 1
        }
    }
}

extinctdist <- function(mu, max_gens=10000, runs=100, firstgensize=1) {
    limz <- 0
    limgens <- 0
    out <- vector("double", runs);
    for (i in seq_along(out)) {
        test = extinctproc(mu, max_gens, firstgensize)
        out[i] <- test[1]
        limz <- limz + test[2]
        limgens <- limgens + test[3]
        #if (mu > 0.9) {print(paste(firstgensize, "with mu:", mu, "(", i, "/", runs, ")"))}
    }
    print(paste(firstgensize, "with mu:", mu, "limz hits:", limz, "limgens hits:", limgens));
    out
}