---
title: "Lab 2 Homework"
author: "Jason Nguyen"
date: "Winter 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to our [GitHub repository](https://github.com/FRS417-DataScienceBiologists). I will randomly select a few examples of student work at the start of each session to use as examples so be sure that your code is working to the best of your ability.

## Load the tidyverse

```r
library("tidyverse")
```

```
## -- Attaching packages ------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.2.1     v purrr   0.3.3
## v tibble  2.1.3     v dplyr   0.8.3
## v tidyr   1.0.0     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.4.0
```

```
## -- Conflicts ---------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## Mammals Sleep
For this assignment, we are going to use built-in data on mammal sleep patterns.  

```r
msleep
```

```
## # A tibble: 83 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Chee~ Acin~ carni Carn~ lc                  12.1      NA        NA      11.9
##  2 Owl ~ Aotus omni  Prim~ <NA>                17         1.8      NA       7  
##  3 Moun~ Aplo~ herbi Rode~ nt                  14.4       2.4      NA       9.6
##  4 Grea~ Blar~ omni  Sori~ lc                  14.9       2.3       0.133   9.1
##  5 Cow   Bos   herbi Arti~ domesticated         4         0.7       0.667  20  
##  6 Thre~ Brad~ herbi Pilo~ <NA>                14.4       2.2       0.767   9.6
##  7 Nort~ Call~ carni Carn~ vu                   8.7       1.4       0.383  15.3
##  8 Vesp~ Calo~ <NA>  Rode~ <NA>                 7        NA        NA      17  
##  9 Dog   Canis carni Carn~ domesticated        10.1       2.9       0.333  13.9
## 10 Roe ~ Capr~ herbi Arti~ lc                   3        NA        NA      21  
## # ... with 73 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

1. From which publication are these data taken from? Don't do an internet search; show the code that you would use to find out in R.


```r
?msleep
```

```
## starting httpd help server ... done
```

2. Put these data into a new object `sleep`. Make sure they are organized as a data frame.  


```r
sleep <- msleep
sleep
```

```
## # A tibble: 83 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Chee~ Acin~ carni Carn~ lc                  12.1      NA        NA      11.9
##  2 Owl ~ Aotus omni  Prim~ <NA>                17         1.8      NA       7  
##  3 Moun~ Aplo~ herbi Rode~ nt                  14.4       2.4      NA       9.6
##  4 Grea~ Blar~ omni  Sori~ lc                  14.9       2.3       0.133   9.1
##  5 Cow   Bos   herbi Arti~ domesticated         4         0.7       0.667  20  
##  6 Thre~ Brad~ herbi Pilo~ <NA>                14.4       2.2       0.767   9.6
##  7 Nort~ Call~ carni Carn~ vu                   8.7       1.4       0.383  15.3
##  8 Vesp~ Calo~ <NA>  Rode~ <NA>                 7        NA        NA      17  
##  9 Dog   Canis carni Carn~ domesticated        10.1       2.9       0.333  13.9
## 10 Roe ~ Capr~ herbi Arti~ lc                   3        NA        NA      21  
## # ... with 73 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

3. Show a list of the column names is this data frame.

```r
colnames(msleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```


4. Use `glimpse()` to summarize the data in `sleep`.

```r
glimpse(sleep)
```

```
## Observations: 83
## Variables: 11
## $ name         <chr> "Cheetah", "Owl monkey", "Mountain beaver", "Greater s...
## $ genus        <chr> "Acinonyx", "Aotus", "Aplodontia", "Blarina", "Bos", "...
## $ vore         <chr> "carni", "omni", "herbi", "omni", "herbi", "herbi", "c...
## $ order        <chr> "Carnivora", "Primates", "Rodentia", "Soricomorpha", "...
## $ conservation <chr> "lc", NA, "nt", "lc", "domesticated", NA, "vu", NA, "d...
## $ sleep_total  <dbl> 12.1, 17.0, 14.4, 14.9, 4.0, 14.4, 8.7, 7.0, 10.1, 3.0...
## $ sleep_rem    <dbl> NA, 1.8, 2.4, 2.3, 0.7, 2.2, 1.4, NA, 2.9, NA, 0.6, 0....
## $ sleep_cycle  <dbl> NA, NA, NA, 0.1333333, 0.6666667, 0.7666667, 0.3833333...
## $ awake        <dbl> 11.9, 7.0, 9.6, 9.1, 20.0, 9.6, 15.3, 17.0, 13.9, 21.0...
## $ brainwt      <dbl> NA, 0.01550, NA, 0.00029, 0.42300, NA, NA, NA, 0.07000...
## $ bodywt       <dbl> 50.000, 0.480, 1.350, 0.019, 600.000, 3.850, 20.490, 0...
```


5. Use `summary()` to summarize the data in `sleep`.

```r
summary(sleep)
```

```
##      name              genus               vore              order          
##  Length:83          Length:83          Length:83          Length:83         
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  conservation        sleep_total      sleep_rem      sleep_cycle    
##  Length:83          Min.   : 1.90   Min.   :0.100   Min.   :0.1167  
##  Class :character   1st Qu.: 7.85   1st Qu.:0.900   1st Qu.:0.1833  
##  Mode  :character   Median :10.10   Median :1.500   Median :0.3333  
##                     Mean   :10.43   Mean   :1.875   Mean   :0.4396  
##                     3rd Qu.:13.75   3rd Qu.:2.400   3rd Qu.:0.5792  
##                     Max.   :19.90   Max.   :6.600   Max.   :1.5000  
##                                     NA's   :22      NA's   :51      
##      awake          brainwt            bodywt        
##  Min.   : 4.10   Min.   :0.00014   Min.   :   0.005  
##  1st Qu.:10.25   1st Qu.:0.00290   1st Qu.:   0.174  
##  Median :13.90   Median :0.01240   Median :   1.670  
##  Mean   :13.57   Mean   :0.28158   Mean   : 166.136  
##  3rd Qu.:16.15   3rd Qu.:0.12550   3rd Qu.:  41.750  
##  Max.   :22.10   Max.   :5.71200   Max.   :6654.000  
##                  NA's   :27
```


6. Print out the first column of the data frame and then print out the first row.

```r
sleep[1,]
```

```
## # A tibble: 1 x 11
##   name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Chee~ Acin~ carni Carn~ lc                  12.1        NA          NA  11.9
## # ... with 2 more variables: brainwt <dbl>, bodywt <dbl>
```

```r
sleep[,1]
```

```
## # A tibble: 83 x 1
##    name                      
##    <chr>                     
##  1 Cheetah                   
##  2 Owl monkey                
##  3 Mountain beaver           
##  4 Greater short-tailed shrew
##  5 Cow                       
##  6 Three-toed sloth          
##  7 Northern fur seal         
##  8 Vesper mouse              
##  9 Dog                       
## 10 Roe deer                  
## # ... with 73 more rows
```


7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 1kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.  

```r
small_mammals <- filter(sleep, bodywt<200)
small_mammals
```

```
## # A tibble: 76 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Chee~ Acin~ carni Carn~ lc                  12.1      NA        NA      11.9
##  2 Owl ~ Aotus omni  Prim~ <NA>                17         1.8      NA       7  
##  3 Moun~ Aplo~ herbi Rode~ nt                  14.4       2.4      NA       9.6
##  4 Grea~ Blar~ omni  Sori~ lc                  14.9       2.3       0.133   9.1
##  5 Thre~ Brad~ herbi Pilo~ <NA>                14.4       2.2       0.767   9.6
##  6 Nort~ Call~ carni Carn~ vu                   8.7       1.4       0.383  15.3
##  7 Vesp~ Calo~ <NA>  Rode~ <NA>                 7        NA        NA      17  
##  8 Dog   Canis carni Carn~ domesticated        10.1       2.9       0.333  13.9
##  9 Roe ~ Capr~ herbi Arti~ lc                   3        NA        NA      21  
## 10 Goat  Capri herbi Arti~ lc                   5.3       0.6      NA      18.7
## # ... with 66 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

```r
large_mammals <- filter(sleep, bodywt > 200)
large_mammals
```

```
## # A tibble: 7 x 11
##   name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Cow   Bos   herbi Arti~ domesticated         4         0.7       0.667  20  
## 2 Asia~ Elep~ herbi Prob~ en                   3.9      NA        NA      20.1
## 3 Horse Equus herbi Peri~ domesticated         2.9       0.6       1      21.1
## 4 Gira~ Gira~ herbi Arti~ cd                   1.9       0.4      NA      22.1
## 5 Pilo~ Glob~ carni Ceta~ cd                   2.7       0.1      NA      21.4
## 6 Afri~ Loxo~ herbi Prob~ vu                   3.3      NA        NA      20.7
## 7 Braz~ Tapi~ herbi Peri~ vu                   4.4       1         0.9    19.6
## # ... with 2 more variables: brainwt <dbl>, bodywt <dbl>
```


8. What is the mean weight for both the large and small mammals?

```r
mean(small_mammals$bodywt)
```

```
## [1] 20.52396
```

```r
mean(large_mammals$bodywt)
```

```
## [1] 1747.071
```

9. Let's try to figure out if large mammals sleep, on average, longer than small mammals. What is the average sleep duration for large mammals as we have defined them?

```r
mean(large_mammals$sleep_total)
```

```
## [1] 3.3
```


10. What is the average sleep duration for small mammals as we have defined them?

```r
mean(small_mammals$sleep_total)
```

```
## [1] 11.09079
```


11. Which animals are the sleepiest? Which sleep least 18 hours per day?  

```r
sleepiest <- filter(sleep, sleep_total>18)
sleepiest$name <- as.factor(sleepiest$name)
levels(sleepiest$name)
```

```
## [1] "Big brown bat"        "Giant armadillo"      "Little brown bat"    
## [4] "Thick-tailed opposum"
```


## Push your final code to GitHub
