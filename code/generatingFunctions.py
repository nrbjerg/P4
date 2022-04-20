#!/usr/bin/env python3
import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np

# G(s)=s
# G(s)=s/2+0.5
# G(s)=s^2/1.2+1-1/1.2
# G(s)=s^2

plt.style.use("ggplot")
x = np.linspace(0, 1, 100)
generating_functions = [
    lambda s: 4 * np.exp(s) / (7 * np.exp(1)) + 0.425,
    lambda s: s * np.exp(s - 1),
    lambda s: np.exp(2 * s ** 2 - 1) / np.exp(1),
]
# plot y = x
plt.plot(x, x, linewidth=1.5, color="black")

for idx, g in enumerate(generating_functions):
    plt.plot(x, g(x), linewidth=1.5, color=["tab:blue", "tab:red", "tab:green"][idx])

plt.xlabel(r"s", fontsize=20)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.ylabel(r"G(s)", fontsize=20)
# plt.legend(["y = x", r])
plt.show()
