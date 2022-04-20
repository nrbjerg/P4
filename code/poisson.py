#!/usr/bin/env python3
import numpy as np
from typing import Callable
import matplotlib.pyplot as plt
import collections
import math


def simulate_pmf(u: float, pmf: Callable[[int], float]) -> int:
    """ Simulates a given pmf """
    s, k = 0, 0
    while True:
        S = s + pmf(k)
        if s < u and u <= S:
            return k
        s = S
        k += 1


# Code used for example
if __name__ == "__main__":
    np.random.seed(0)
    plt.style.use("ggplot")
    # Construct the pmf of the poisson distrobution
    lmbda = 1
    pmf = lambda k: np.exp(-1) * (np.power(lmbda, k)) / math.factorial(k)
    # Simulate the different number of datapoints
    max_number_of_ks = 0
    ns = [100, 1000, 5000]
    for idx, n in enumerate(ns):
        simulated_points = [simulate_pmf(np.random.rand(), pmf) for _ in range(n)]
        table = collections.Counter(simulated_points)
        ks = table.keys()
        if max_number_of_ks < len(ks):
            max_number_of_ks = len(ks)

        simulated_pmf_values = np.array(list(table.values()), dtype="int") / n

        plt.bar(
            [k - 0.3 + idx / 5 for k in ks],
            simulated_pmf_values,
            width=0.15,
            color=["tab:green", "tab:red", "tab:orange"][idx],
        )

    # Plot the true pmf
    positions = [k + 0.30 for k in range(max_number_of_ks)]
    plt.bar(
        positions,
        [pmf(k) for k in range(max_number_of_ks)],
        width=0.15,
        color="tab:blue",
    )

    plt.xlabel("k", fontsize=20)
    plt.ylabel(r"p(k)", fontsize=20)
    plt.xlim([-0.5, 5.5])  # We dont want the values for k > 5
    plt.legend([f"Simulated (n = {n})" for n in ns] + ["True pmf"], prop={"size": 14})
    plt.xticks(fontsize=14)
    plt.yticks(fontsize=14)

    plt.show()
