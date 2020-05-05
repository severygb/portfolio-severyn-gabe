Price and fuel economy are mutually exclusive
================

There is a strongly inverse correlation between vehicle price and
highway fuel economy. Of the cars imported into the US in 1985, there
were not expensive cars that achieved good fuel economy nor were there
inexpensive cars with poor fuel economy (Dua and Graff,
[2017](#ref-Dua:2019)).

<img src="../figures/D3-scatterplot-imports.png" width="100%" />

An explanation of the trend can be traced back to companies producing
products that satisfy consumer preferences. Simply put, brands make cars
people want to buy- theoretically. The following explanations make sense
from the view of the producer targeting consumers. No conclusions can be
made about which vehicles actually appealed to consumers and sold, since
this data does not include sales or profit information.

Sedan and hatchbacks and wagons strongly exhibit an inverse correlation
between price and economy. A budget conscious shopper prioritizes low
overall costs: made up of both initial price and operating costs in
fuel. Hatchbacks are the lowest cost style of car, and also have some of
the highest economy numbers.

Fuel economy is much lower in convertibles and coupes because those
buyers have different priorities. Around and above the $30,000 mark
exist only Porsches, a luxury-performance brand, and Mercedes-Benz, the
utmost in luxury cars.

There are a few things wrong with this data. It does not represent
domestic manufacturers well, because any american models are merely
captive-imports: models built by overseas manufactures but sold under
domestic names. For inexplicable reasons it does not include trucks
either. This limited view is still meaningful however, because the US
was the largest automobile market at the time.

Finding this data for domestic cars may provide additional context to
this story. Perhaps foreign companies produce more economical cars
because the domestic producers are leaving that market segment empty. I
am sure this story would be drastically different with data from current
years, both because automotive market segments are more diverse than
ever and because of recent focus on economy and electrification. As
always, there are more questions than answers.

## Graph design

Data requirements

  - Minimum 100 observations
  - Two quantitative variables
  - One categorical variable with at least 5 levels
  - Time is excluded as a variable

Both factors are ordered by economy, which easily shows which style and
brand are the most efficient. Who said “order by the data”?

Price is formatted in standard currency form, which enables immediate
understanding. Care was taken to eliminate label overprinting- the exact
opposite of clarity.

One of Wainer’s sarcastic visualization rules is “emphasize the trivial,
ignore the important” (Wainer, [2000](#ref-Wainer:2000)). He means to
place important comparisons such that they are easy to make. To
facilitate comparing mileage across each body style, it is placed on the
y-axis, which is common for all facets.

Pulled from a repositoty for machine learning, this data set strongly
resembles the mtcars data included in R. This was not intentional, I
just sought out data on cars because that’s what I am interested in, and
found the similarity through tutorials that used mtcars.

## References

<div id="refs" class="references">

<div id="ref-Dua:2019">

Dua D and Graff C (2017) UCI machine learning repository automobile data
set. <https://archive.ics.uci.edu/ml/datasets/Automobile>

</div>

<div id="ref-Wainer:2000">

Wainer H (2000) *Visual revelations: Graphical tales of fate and
deception from napoleon bonaparte to ross perot.*
(doi:[10.2307/2685574](https://doi.org/10.2307/2685574))

</div>

</div>
