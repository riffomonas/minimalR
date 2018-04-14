0	Introduction to R and RStudio

1	Introduction to plotting
* Break down what is happening in the initial chunk of code
	- Importing data
	- Merging data sets
	- Plotting
		- grammar of graphics
* aes vs plotting characteristic
	- colors
	- shapes
	- size
	- position (x, y)
	- transparency
* packages
* getting help


2 Reading in and cleaning data from files
* read_*/read.xlsx functions
* tidy data
	* reshaping data
* tibbles / data frames
	* head
	* tail
	* glimpse / str
	* View
	* summary
* data types


3 Joining and exploring data frames
dplyr::joins
dplyr::filtering
dplyr::select
Filtering / Selecting / Pipe
pipes


4 Analyzing data in data frames

dplyr::count
dplyr::group_by
dplyr::arrange
dplyr::summarise
dplyr::mutate
dplyr::mutate_at
functions


5 Working with continuous data across discrete categories

geom_col
geom_errorbar
geom_violin
geom_jitter
geom_boxplot
factor


5 Working with single variables
* Discrete
* Continuous
* Histograms - are data normally distributed?
* Density plots
* Points
* Transforming data
* Generate random data



Statistical testing


Scripting


vectors


apply functions

scripts
faceting

regex: gsub
regex: grep

* put heat colors on ordination/scatter plot
* Over plotting line for median
* Text annotation of figures
* themes

Heatmaps



7	Line plots
* Regular expressions - grep and gsub
* Rarefaction curves
* Building plots
* Loops

8 Working with OTU data
* String manipulations - strsplit and paste
* Regular expressions - more complex patterns
* Apply functions
* if ... else

9	Plotting taxonomic data
* Pie charts
* Stacked bar plots
* Bar plots
* Strip charts

10	Finding relevant OTUs to plot
* Kruskal-Wallis test
* Correcting for multiple hypotheses
* Plotting OTU data
* Getting help

11	Classifying samples based on OTUs
* Random forest

11	Heat maps
* OTUs by categorical variables
* Color palettes
* Hacking
* Italics

12	Dot plots
* Percentage by categorical variables
* Hacking

13	Putting it together: Simulations in R

14	Putting it together: Bi-plots

1X Unit tests

1X
rentrez - Pulling down web data
Diagrams

1X	Building interactivity
* rgl

1X	Writing
* kable
* xtable
* citations

1X	ggplot2

1X	Network

1X	Shiny app

1X	googleViz

1X	building a package

Reading in data from websites



* Polygons ~ back to back plot?
* Drawing - making a mouse model
* dplyr workflow
* models / plotting fits
* format / round


## Tidy data

We've been using a number of packages from the "tidyverse", but we've never actually defined it. "Tidy data" refers to the idea that data can be structured to simplify analysis such that...
(need to fix definition)
> 1. Each variable forms a column.
> 2. Each observation forms a row.
> 3. Each type of observational unit forms a table.

If you're familiar with relational databases, this should sound familiar. As an example, consider the following data taken from `data/baxter.subsample.shared`

label  | Group   | numOtus | Otu000001 | Otu000002 | Otu000003 | Otu000004 | Otu000005 |
-------|---------|---------|-----------|-----------|-----------|-----------|-----------|
0.0300 | 2003650 |  5450   |    363    |   290     |   284     |   218     |   253     |
0.0300 | 2005650 |  5450   |    593    |   706     |  1360     |   253     |   107     |
0.0300 | 2007660 |  5450   |    143    |   236     |   769     |   589     |   354     |
0.0300 | 2009650 |  5450   |    327    |   203     |    31     |   249     |   205     |
0.0300 | 2013660 |  5450   |   1423    |     8     |   183     |   642     |  1124     |

We could argue that the columns containing the OTU count data are not tidy because they contain the same type of data (i.e. counts of sequences in OTUs). In contrast, the following table would be tidy:

| label|   Group| numOtus|OTU       | counts|
|-----:|-------:|-------:|:---------|------:|
|  0.03| 2003650|    5450|Otu000001 |    363|
|  0.03| 2005650|    5450|Otu000001 |    593|
|  0.03| 2007660|    5450|Otu000001 |    143|
|  0.03| 2009650|    5450|Otu000001 |    327|
|  0.03| 2013660|    5450|Otu000001 |   1423|
|  0.03| 2003650|    5450|Otu000002 |    290|
|  0.03| 2005650|    5450|Otu000002 |    706|
|  0.03| 2007660|    5450|Otu000002 |    236|
|  0.03| 2009650|    5450|Otu000002 |    203|
|  0.03| 2013660|    5450|Otu000002 |      8|
|  0.03| 2003650|    5450|Otu000003 |    284|
|  0.03| 2005650|    5450|Otu000003 |   1360|
|  0.03| 2007660|    5450|Otu000003 |    769|
|  0.03| 2009650|    5450|Otu000003 |     31|
|  0.03| 2013660|    5450|Otu000003 |    183|
|  0.03| 2003650|    5450|Otu000004 |    218|
|  0.03| 2005650|    5450|Otu000004 |    253|
|  0.03| 2007660|    5450|Otu000004 |    589|
|  0.03| 2009650|    5450|Otu000004 |    249|
|  0.03| 2013660|    5450|Otu000004 |    642|
|  0.03| 2003650|    5450|Otu000005 |    253|
|  0.03| 2005650|    5450|Otu000005 |    107|
|  0.03| 2007660|    5450|Otu000005 |    354|
|  0.03| 2009650|    5450|Otu000005 |    205|
|  0.03| 2013660|    5450|Otu000005 |   1124|
