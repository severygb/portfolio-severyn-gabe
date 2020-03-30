Test Report
================
Gabe Severyn
2020-03-30

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

## Introduction

This display illustrat es the distribution of speeds attained by skiers
in three downhill events in the 2012 Olympic Winter Games disaggregated
by sex.

## Requirements

This display meets the data requirements for D1 distributions

  - 250 observations
  - One quantitative variable (speed)
  - Two categorical variables: sex (2 levels) and event (3 levels)

This display also meets the following document requirements

  - sports data limit (this display is one of two)

The following is a glimpse of StarWars characters.

    ## Observations: 87
    ## Variables: 13
    ## $ name       <chr> "Luke Skywalker", "C-3PO", "R2-D2", "Darth Vader", "Leia...
    ## $ height     <int> 172, 167, 96, 202, 150, 178, 165, 97, 183, 182, 188, 180...
    ## $ mass       <dbl> 77.0, 75.0, 32.0, 136.0, 49.0, 120.0, 75.0, 32.0, 84.0, ...
    ## $ hair_color <chr> "blond", NA, NA, "none", "brown", "brown, grey", "brown"...
    ## $ skin_color <chr> "fair", "gold", "white, blue", "white", "light", "light"...
    ## $ eye_color  <chr> "blue", "yellow", "red", "yellow", "brown", "blue", "blu...
    ## $ birth_year <dbl> 19.0, 112.0, 33.0, 41.9, 19.0, 52.0, 47.0, NA, 24.0, 57....
    ## $ gender     <chr> "male", NA, NA, "male", "female", "male", "female", NA, ...
    ## $ homeworld  <chr> "Tatooine", "Tatooine", "Naboo", "Tatooine", "Alderaan",...
    ## $ species    <chr> "Human", "Droid", "Droid", "Human", "Human", "Human", "H...
    ## $ films      <list> [<"Revenge of the Sith", "Return of the Jedi", "The Emp...
    ## $ vehicles   <list> [<"Snowspeeder", "Imperial Speeder Bike">, <>, <>, <>, ...
    ## $ starships  <list> [<"X-wing", "Imperial shuttle">, <>, <>, "TIE Advanced ...

    ## [1] "Revenge of the Sith"     "Return of the Jedi"     
    ## [3] "The Empire Strikes Back" "A New Hope"             
    ## [5] "The Force Awakens"       "Attack of the Clones"   
    ## [7] "The Phantom Menace"

Graph of worlds and number of characters all it home.
![](0301-markdown-basics_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

This is the output of a separate R script.

    ## -- Attaching packages --------------------------------------------------------------- tidyverse 1.3.0 --

    ## v tibble  2.1.3     v purrr   0.3.3
    ## v tidyr   1.0.2     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ------------------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()
