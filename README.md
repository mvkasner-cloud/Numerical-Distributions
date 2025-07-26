# Numerical-Distributions
Numerical frequency distribution with an interval size of 20 and calculate the cumulative relative frequency.


## This repository contains three implementations of the same data analysis task using different tools:

- **Excel** (using **Pivot Table** and formulas compatible with both **Excel 365** and older versions)
- **SQL** (**SQL Server Management Studio**)
- **Python** (**pandas**, **numpy**, and **matplotlib** in **VS Code** using **Jupyter Notebook**)
 

### What Each Solution Does:

- Groups salaries using the formula: FLOOR((salary - 10) / 20) * 20 + 10. This assigns each salary to a range like 70–90, 90–110, etc.

- Counts how many salaries fall into each range

- Calculates relative frequency and the cumulative relative frequency (%)

- Outputs a summary table with all the results

- Plots a histogram (in Python) to visualize the salary distribution



