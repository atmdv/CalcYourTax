Calculate your tax easily, and get feedback on how to optimize your tax
-----------------------------------------------------------------------

Income from stock holdings outside of retirement savings accounts is taxed with two different tax rates, 27 percent and 42 percent respectively, depending on which tax bracket the income falls into.

This package allows you to easily import data from Nordnet portfolio accounts. It then automatically calculates your total taxable income, and provides advice on actions to take to optimize the long term taxation on your income from stocks. In order to optimize the tax rate, the income in the lowest tax bracket should be maximized. Conversely, income in the highest tax bracket should be minimized.

How it works
============

First step is to export the entire transaction history from you Nordnet portfolio account. Then specify the file path for the transactions file.

``` r
nordnet <- "transaktionsfil.csv"
```

Now with a single function call, calculate your taxable income for every year in the transactions history:

``` r
tax_income <- calcyourtax(nordnet)
```

<table>
<thead>
<tr>
<th style="text-align:left;">
year
</th>
<th style="text-align:right;">
profit
</th>
<th style="text-align:right;">
dividend
</th>
<th style="text-align:right;">
tax\_income
</th>
<th style="text-align:right;">
bracket\_limit
</th>
<th style="text-align:left;">
how\_to\_optimize
</th>
<th style="text-align:right;">
amount
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2016
</td>
<td style="text-align:right;">
10818.66
</td>
<td style="text-align:right;">
9341.37
</td>
<td style="text-align:right;">
20160.03
</td>
<td style="text-align:right;">
50600
</td>
<td style="text-align:left;">
Realize Gains
</td>
<td style="text-align:right;">
30439.97
</td>
</tr>
<tr>
<td style="text-align:left;">
2017
</td>
<td style="text-align:right;">
21877.65
</td>
<td style="text-align:right;">
11861.68
</td>
<td style="text-align:right;">
33739.33
</td>
<td style="text-align:right;">
51700
</td>
<td style="text-align:left;">
Realize Gains
</td>
<td style="text-align:right;">
17960.67
</td>
</tr>
<tr>
<td style="text-align:left;">
2018
</td>
<td style="text-align:right;">
-884.58
</td>
<td style="text-align:right;">
43644.49
</td>
<td style="text-align:right;">
42759.91
</td>
<td style="text-align:right;">
52900
</td>
<td style="text-align:left;">
Realize Gains
</td>
<td style="text-align:right;">
10140.09
</td>
</tr>
</tbody>
</table>
So in each of the previous three years I should have realized more gains in order to maximize my income in the lowest tax bracket. Too bad I didn't have this tool handy!

To-do:
======

-   Package functions
-   Add detailed data for country specific withheld tax rates on dividends
-   Add support for DeGiro accounts
