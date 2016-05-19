missing...
* if ... else if ... else

We can convert the `ifelse` statement into an `if... else if ... else` statement instead.

```{r}
get_bmi_category <- function(bmi){
	category <- NA

	if(bmi >= 30){
 		category <- "obese"
	} else if(bmi >= 25){
		category <- "overweight"
	} else if(bmi >= 18.5){
		category <- "normal"
	} else {
		category <- "underweight"
	}

	return(category)
}

get_bmi_category(c(10, 15, 20, 25, 30, 35, 40))
```

Lists
Here we find a new type of data structure - "List". A list is similar to a data frame in that it can hold many different types of data, however, the length of each entity in the list is not the same. Here we see there is a value `breaks` that is a vector of length 21 while the length of `counts` is 20 and `xname` is a character with one value. Do you recall in our discussion of functions that you can only return one variable? That sounds like a significant limitation, but really it isn't. So far we've seen functions that have returned a vector (e.g. `mean` and `summary`), a data frame (e.g. `aggregate`), or a matrix (e.g. `hist`). Although we haven't discussed it, we've seen other functions that return lists (e.g. `aov` and `summary`). Returning a list allows us to have a function that returns multiple data types contained within one variable.




* models / plotting fits
* Xapply functions


0	Introduction to R and RStudio

1	Ordination
* Plotting
* Symbols and colors
* Axis labels

2	Plotting metadata as an attribute
* Reading data files
* Survey of metadata
* Data clean up
* Subsetting data
* Plotting metadata on top of scatter data

3	Plotting pairs of continuous data with scatter plots
* dplyr joins
* Legends
* Margins
* Calculating correlations

4	Plotting continuous by categorical data
* Functions
* Sourcing R scripts
* Controlling flow with `ifelse`
* Aggregating function
* Matrices
* Barplots - Legends; from Vectors, Matrices, t(Matrices)
* Error bar - standard deviation

5 Working with random data
* Histograms - are data normally distributed?
* Density plots
* Points
* Transforming data
* Generate random data
* Saving plots

6	Plotting non-normal data
* Box plots
* Custom box plot (building your own plots)
*	Strip charts
* Over plotting line for median

7	Line plots
* Rarefaction curves
* Loops

8 Area plots
* Pie charts - otus by categorical variables
* Stacked bar plots - otus by categorical variables
* Back to back bar plot

9 Text processing
* Regular expressions
* Italics
* OTU strip charts
* format / round

10	Plotting OTU data
* Wilcox-test
* Bar plots
* Strip charts
* Point +/- std error

11	Dot plots
* Percentage by categorical variables
* Hacking

12	Heat maps
* OTUs by categorical variables
* Color palettes
* Hacking

13	Putting it together: Simulations in R


14	Putting it together: Bi-plots


1X
rentrez - Pulling down web data
Diagrams

1X	Building interactivity
* rgl
* kable
* xtable
* citations

1X	ggplot2

1X	Network

1X	Shiny app

1X	googleViz

1X	building a package


* Polygons
* Segments
* Functions
* Drawing - making a mouse model
* dplyr workflow
* abline
