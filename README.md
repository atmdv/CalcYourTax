Calculate your tax easily, and get feedback on how to optimize your tax
-----------------------------------------------------------------------

Income from stock holdings outside of retirement savings accounts is taxed with two different tax rates, 27 percent and 42 percent respectively, depending on which tax bracket the income falls into.

This package allows you to easily import data from Nordnet portfolio accounts. It then automatically calculates your total taxable income, and provides advice on actions to take to optimize the long term taxation on your income from stocks. In order to optimize the tax rate, the income in the lowest tax bracket should be maximized. Conversely, income in the highest tax bracket should be minimized.

How it works
============

First step is to export the entire transaction history from your Nordnet portfolio account. Then specify the file path for the transactions file.

``` r
nordnet <- "transaktionsfil.csv"
```

Now with a single function call, calculate your taxable income for every year in the transactions history:

``` r
devtools::install_github("atmdv/CalcYourTax")
```

    ## Downloading GitHub repo atmdv/CalcYourTax@master

    ## 
    ##   
      
      
       checking for file 'C:\Users\Andreas Tyge Moller\AppData\Local\Temp\RtmpuYeGvY\remotes2f9043473144\atmdv-CalcYourTax-d4af456/DESCRIPTION' ...
      
       checking for file 'C:\Users\Andreas Tyge Moller\AppData\Local\Temp\RtmpuYeGvY\remotes2f9043473144\atmdv-CalcYourTax-d4af456/DESCRIPTION' ... 
      
    v  checking for file 'C:\Users\Andreas Tyge Moller\AppData\Local\Temp\RtmpuYeGvY\remotes2f9043473144\atmdv-CalcYourTax-d4af456/DESCRIPTION'
    ## 
      
      
      
    -  preparing 'CalcYourTax':
    ## 
      
       checking DESCRIPTION meta-information ...
      
       checking DESCRIPTION meta-information ... 
      
    v  checking DESCRIPTION meta-information
    ## 
      
      
      
    -  checking for LF line-endings in source and make files and shell scripts
    ## 
      
    -  checking for empty or unneeded directories
    ## 
      
    -  building 'CalcYourTax_0.1.tar.gz'
    ## 
      
    Warning in utils::tar(filepath, pkgname, compression = "gzip", compression_level = 9L,  :
      
       Warning in utils::tar(filepath, pkgname, compression = "gzip", compression_level = 9L,  :
    ##      file 'CalcYourTax/Opg+©relse.R' not found
    ## 
      
    Warning in utils::tar(filepath, pkgname, compression = "gzip", compression_level = 9L,  :
      
       Warning in utils::tar(filepath, pkgname, compression = "gzip", compression_level = 9L,  :
    ##      file 'CalcYourTax/V+ªrdipapirstatus.R' not found
    ## 
      
       
    ## 

    ## Installing package into 'C:/Users/Andreas Tyge Moller/R/win-library/3.5'
    ## (as 'lib' is unspecified)

``` r
library(CalcYourTax)
tax_income <- calcyourtax(nordnet)
```

| Year |  Profits|  Dividends|  Tax Income|  Bracket limit| How to optimize |  Amount|
|:----:|--------:|----------:|-----------:|--------------:|:----------------|-------:|
| 2016 |   10,819|      9,341|      20,160|         50,600| Realize Gains   |  30,440|
| 2017 |   21,878|     11,862|      33,739|         51,700| Realize Gains   |  17,961|
| 2018 |     -885|     43,644|      42,760|         52,900| Realize Gains   |  10,140|

So in each of the previous three years I should have realized more gains in order to maximize my income in the lowest tax bracket. Too bad I didn't have this tool handy!

To-do:
======

-   Add additional details for country specific withheld tax rates on dividends
-   Add support for DeGiro accounts
