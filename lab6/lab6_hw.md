---
title: "Lab 6 Homework"
author: "Jason Nguyen"
date: "February 15, 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run.  

## Libraries

```r
library(tidyverse)
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we used for the practice midterm. You may want to load that assignment for reference.  

```r
#install.packages("gapminder")
library("gapminder")
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NAs are treated in the data.**  

```r
dim(gapminder)
```

```
## [1] 1704    6
```


```r
colnames(gapminder)
```

```
## [1] "country"   "continent" "year"      "lifeExp"   "pop"       "gdpPercap"
```


```r
glimpse(gapminder)
```

```
## Observations: 1,704
## Variables: 6
## $ country   <fct> Afghanistan, Afghanistan, Afghanistan, Afghanistan, Afgha...
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 199...
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 4...
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372,...
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.113...
```


```r
nlevels(gapminder$country)
```

```
## [1] 142
```

```r
naniar::miss_var_summary(gapminder)
```

```
## # A tibble: 6 x 3
##   variable  n_miss pct_miss
##   <chr>      <int>    <dbl>
## 1 country        0        0
## 2 continent      0        0
## 3 year           0        0
## 4 lifeExp        0        0
## 5 pop            0        0
## 6 gdpPercap      0        0
```


```r
summary(gapminder)
```

```
##         country        continent        year         lifeExp     
##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
##  Australia  :  12                  Max.   :2007   Max.   :82.60  
##  (Other)    :1632                                                
##       pop              gdpPercap       
##  Min.   :6.001e+04   Min.   :   241.2  
##  1st Qu.:2.794e+06   1st Qu.:  1202.1  
##  Median :7.024e+06   Median :  3531.8  
##  Mean   :2.960e+07   Mean   :  7215.3  
##  3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
##  Max.   :1.319e+09   Max.   :113523.1  
## 
```

**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**

```r
gapminder %>%
  select(year, lifeExp) %>% 
  group_by(year) %>% 
  summarize(global_lifeExp = sum(lifeExp))
```

```
## # A tibble: 12 x 2
##     year global_lifeExp
##    <int>          <dbl>
##  1  1952          6966.
##  2  1957          7314.
##  3  1962          7613.
##  4  1967          7906.
##  5  1972          8186.
##  6  1977          8459.
##  7  1982          8738.
##  8  1987          8976.
##  9  1992          9111.
## 10  1997          9232.
## 11  2002          9329.
## 12  2007          9515.
```

```r
gapminder %>%
  group_by(year) %>% 
  summarize(global_lifeExp = sum(lifeExp)) %>% 
  ggplot(aes(x=year, y=global_lifeExp))+
  geom_point(color="turquoise4") +
  geom_line(color="turquoise3") +
  labs(title="Global Life Expectancy from 1952 to 2007",
       x= "Year",
       y="Life Expectancy") +
  theme(plot.title = element_text(size = rel(2), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

**3. How do the distributions of life expectancy compare for the years 1952 and 2007? _Challenge: Can you put both distributions on a single plot?_**

```r
gapminder %>%
  filter(year %in% c(1952, 2007)) %>%
  select(year, lifeExp) %>% 
  group_by(year) %>% 
  summarize(min_lifeExp=min(lifeExp),
            max_lifeExp=max(lifeExp),
            mean_lifeExp=mean(lifeExp),
            median_lifeEx=median(lifeExp))
```

```
## # A tibble: 2 x 5
##    year min_lifeExp max_lifeExp mean_lifeExp median_lifeEx
##   <int>       <dbl>       <dbl>        <dbl>         <dbl>
## 1  1952        28.8        72.7         49.1          45.1
## 2  2007        39.6        82.6         67.0          71.9
```


```r
gapminder %>%
  filter(year %in% c(1952, 2007)) %>%
  ggplot(aes(x=year, y=lifeExp, group=year))+
  geom_boxplot(fill="turquoise3", alpha=.6) +
  labs(title="Global Life Expectancy",
       x= "Year",
       y="Life Expectancy") +
  theme(plot.title = element_text(size = rel(2), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**

```r
gapminder %>%
  select(continent, year, lifeExp) %>% 
  group_by(continent) %>% 
  summarize(min_lifeExp=min(lifeExp),
            max_lifeExp=max(lifeExp),
            mean_lifeExp=mean(lifeExp),
            median_lifeEx=median(lifeExp))
```

```
## # A tibble: 5 x 5
##   continent min_lifeExp max_lifeExp mean_lifeExp median_lifeEx
##   <fct>           <dbl>       <dbl>        <dbl>         <dbl>
## 1 Africa           23.6        76.4         48.9          47.8
## 2 Americas         37.6        80.7         64.7          67.0
## 3 Asia             28.8        82.6         60.1          61.8
## 4 Europe           43.6        81.8         71.9          72.2
## 5 Oceania          69.1        81.2         74.3          73.7
```


```r
gapminder %>%
  ggplot(aes(x=continent, y=lifeExp, group=continent, fill=continent))+
  geom_boxplot(alpha=.6) +
  labs(title="Global Life Expectancy by Continent",
       x= "Continent",
       y="Life Expectancy") +
  theme(plot.title = element_text(size = rel(2), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->


**5. How has life expectancy changed between 1952-2007 for each continent? Try using `geom_line()` for this, including all continents on the same  plot.**

```r
gapminder %>% 
  select(continent, year, lifeExp) %>% 
  group_by(continent, year) %>% 
    summarize(mean_lifeExp=mean(lifeExp))
```

```
## # A tibble: 60 x 3
## # Groups:   continent [5]
##    continent  year mean_lifeExp
##    <fct>     <int>        <dbl>
##  1 Africa     1952         39.1
##  2 Africa     1957         41.3
##  3 Africa     1962         43.3
##  4 Africa     1967         45.3
##  5 Africa     1972         47.5
##  6 Africa     1977         49.6
##  7 Africa     1982         51.6
##  8 Africa     1987         53.3
##  9 Africa     1992         53.6
## 10 Africa     1997         53.6
## # ... with 50 more rows
```


```r
gapminder %>% 
  group_by(year, continent) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  ggplot(aes(x=year, y=mean_lifeExp, color=continent))+
  geom_point() +
  geom_line(alpha=.6) +
  labs(title="Global Life Expectancy by Continent",
       x= "Year",
       y="Life Expectancy") +
  theme(plot.title = element_text(size = rel(2), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**

```r
gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp))+
  geom_jitter()
```

![](lab6_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


**7. There is extreme disparity in per capita GDP. Rescale the x axis to make this easier to interpret. How would you characterize the relationship?**

```r
gapminder %>% 
  filter(gdpPercap <=50000) %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp))+
  geom_jitter() +
  labs(title = "GDP Per Capita vs. Life Expectancy",
       x= "GDP Per Capita",
       y= "Life Expectancy") +
  theme(plot.title = element_text(size = rel(2), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

#### I would characterize the relationship as a logarithmic curve or proportional to each other.

**8. Which countries have had the largest population growth since 1952?**

```r
gapminder %>% 
  select(country, year, pop) %>%
  group_by(country) %>% 
  summarize(pop_growth = last(pop)-first(pop)) %>% 
  arrange(desc(pop_growth))
```

```
## # A tibble: 142 x 2
##    country       pop_growth
##    <fct>              <int>
##  1 China          762419569
##  2 India          738396331
##  3 United States  143586947
##  4 Indonesia      141495000
##  5 Brazil         133408087
##  6 Pakistan       127924057
##  7 Bangladesh     103561480
##  8 Nigeria        101912068
##  9 Mexico          78556574
## 10 Philippines     68638596
## # ... with 132 more rows
```

**9. Use your results from the question above to plot population growth for the top five countries since 1952.**

```r
gapminder %>%
  filter(country == "China" |
           country == "India" | 
           country == "United States" | 
           country == "Indonesia" |
           country == "Brazil") %>% 
  ggplot(aes(x=year, y=pop, color=country)) +
  geom_point() +
  geom_line() +
  labs(title = "Top 5 Population Growths by Country",
       x= "Year",
       y= "Population") +
  theme(plot.title = element_text(size = rel(2), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

**10. How does per capita GDP growth compare between these same five countries?**

```r
gapminder %>%
  filter(country == "China" |
           country == "India" | 
           country == "United States" | 
           country == "Indonesia" |
           country == "Brazil") %>% 
  ggplot(aes(x=year, y=gdpPercap, color=country)) +
  geom_point() +
  geom_line() +
   labs(title = "GDP per Capita Growth for the Top 5 Countries with the Largest Population Growth",
       x= "Year",
       y= "GDP Per Capita") +
  theme(plot.title = element_text(size = rel(1), hjust = 0.5))
```

![](lab6_hw_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
