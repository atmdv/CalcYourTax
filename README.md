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
10,819
</td>
<td style="text-align:right;">
9,341
</td>
<td style="text-align:right;">
20,160
</td>
<td style="text-align:right;">
50,600
</td>
<td style="text-align:left;">
Realize Gains
</td>
<td style="text-align:right;">
30,440
</td>
</tr>
<tr>
<td style="text-align:left;">
2017
</td>
<td style="text-align:right;">
21,878
</td>
<td style="text-align:right;">
11,862
</td>
<td style="text-align:right;">
33,739
</td>
<td style="text-align:right;">
51,700
</td>
<td style="text-align:left;">
Realize Gains
</td>
<td style="text-align:right;">
17,961
</td>
</tr>
<tr>
<td style="text-align:left;">
2018
</td>
<td style="text-align:right;">
-885
</td>
<td style="text-align:right;">
43,644
</td>
<td style="text-align:right;">
42,760
</td>
<td style="text-align:right;">
52,900
</td>
<td style="text-align:left;">
Realize Gains
</td>
<td style="text-align:right;">
10,140
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
