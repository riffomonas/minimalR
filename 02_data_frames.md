---
layout: lesson
title: "Session 2: Data Frames"
output: markdown_document
---

## Learning goals

* Read in data from various file formats
* Write data out to various file formats
* Clean up data frames
* Data types
* Value of keeping raw data, raw
* Importance of how things are named



## Getting data into R
Let's revisit the chunk of code that we started out with at the beginning of the last lesson


```r
library(tidyverse)
library(readxl)

pcoa <- read_tsv(file="raw_data/baxter.thetayc.pcoa.axes")
metadata <- read_excel(path="raw_data/baxter.metadata.xlsx")
pcoa_metadata <- inner_join(pcoa, metadata, by=c('group'='sample'))

ggplot(pcoa_metadata, aes(x=axis1, y=axis2, color=dx)) +
	geom_point(shape=19, size=2) +
	scale_color_manual(name=NULL,
		values=c("blue", "red", "black"),
		breaks=c("normal", "adenoma", "cancer"),
		labels=c("Normal", "Adenoma", "Cancer")) +
	coord_fixed() +
	labs(title="PCoA of ThetaYC Distances Between Stool Samples",
		x="PCo Axis 1",
		y="PCo Axis 2") +
	theme_classic()

ggsave("ordination.pdf")
```




After loading the `tidyverse` and `readxl` packages, there are two lines where we read in data:

```R
pcoa <- read_tsv(file="raw_data/baxter.thetayc.pcoa.axes")
metadata <- read_excel(path="raw_data/baxter.metadata.xlsx")
```

These two lines read in our ordination data and the data about the samples represented in the ordination (i.e. metadata). The first line uses the function, `read_tsv` to read in a **t**ab **s**eparated **v**alues-formatted file. As the name suggests, this function will read in a file where the columns in the file are separated by tab characters. This function comes from the [`readr` package](http://readr.tidyverse.org) that was loaded as part of the `tidyverse` package. This package also has functions for reading in **c**omma **s**separated **v**alues (CSVs) files (`read_csv`), general delimited files (`read_delim`), fixed width files (`read_fwf`), and file where columns are separated by whitespace (`read_table`). As the name suggests, the second line of code relies on the `read_excel` function from the [`readxl` package](http://readxl.tidyverse.org) to read a table in from a Microsoft Excel-formatted spreadsheet. Within the `tidyverse`, there are  the [`haven` package](http://haven.tidyverse.org/index.html), which can be used to read in SAS, SPSS, and Stata-formatted files. There are a number of other reading packages that aren't specifically part of the `tidyverse`, but that do allow you to read in data from websites, databases, and other sources**.**

Each of these functions has a decent number of options that default to values that make sense. Be careful - there are other similarly named functions (e.g. `read.tsv`) that are actually built into R and have different defaults that don't make sense. What are the defaults? What options can we change? Remember from the last lesson that we can use the `?` to get the documentation for any function

```R
?read_tsv
```

```
read_delim                package:readr                R Documentation

Read a delimited file (including csv & tsv) into a tibble

Description:

     ‘read_csv()’ and ‘read_tsv()’ are special cases of the general
     ‘read_delim()’. They're useful for reading the most common types
     of flat file data, comma separated values and tab separated
     values, respectively. ‘read_csv2()’ uses ‘;’ for separators,
     instead of ‘,’. This is common in European countries which use ‘,’
     as the decimal separator.

Usage:

     read_delim(file, delim, quote = "\"", escape_backslash = FALSE,
       escape_double = TRUE, col_names = TRUE, col_types = NULL,
       locale = default_locale(), na = c("", "NA"), quoted_na = TRUE,
       comment = "", trim_ws = FALSE, skip = 0, n_max = Inf,
       guess_max = min(1000, n_max), progress = show_progress())

     read_csv(file, col_names = TRUE, col_types = NULL,
       locale = default_locale(), na = c("", "NA"), quoted_na = TRUE,
       quote = "\"", comment = "", trim_ws = TRUE, skip = 0, n_max = Inf,
       guess_max = min(1000, n_max), progress = show_progress())

     read_csv2(file, col_names = TRUE, col_types = NULL,
       locale = default_locale(), na = c("", "NA"), quoted_na = TRUE,
       quote = "\"", comment = "", trim_ws = TRUE, skip = 0, n_max = Inf,
       guess_max = min(1000, n_max), progress = show_progress())

     read_tsv(file, col_names = TRUE, col_types = NULL,
       locale = default_locale(), na = c("", "NA"), quoted_na = TRUE,
       quote = "\"", comment = "", trim_ws = TRUE, skip = 0, n_max = Inf,
       guess_max = min(1000, n_max), progress = show_progress())

Arguments:

    file: Either a path to a file, a connection, or literal data
          (either a single string or a raw vector).

          Files ending in ‘.gz’, ‘.bz2’, ‘.xz’, or ‘.zip’ will be
          automatically uncompressed. Files starting with ‘http://’,
          ‘https://’, ‘ftp://’, or ‘ftps://’ will be automatically
          downloaded. Remote gz files can also be automatically
          downloaded and decompressed.

          Literal data is most useful for examples and tests. It must
          contain at least one new line to be recognised as data
          (instead of a path).

   delim: Single character used to separate fields within a record.

   quote: Single character used to quote strings.

escape_backslash: Does the file use backslashes to escape special
          characters? This is more general than ‘escape_double’ as
          backslashes can be used to escape the delimiter character,
          the quote character, or to add special characters like ‘\n’.

escape_double: Does the file escape quotes by doubling them? i.e. If
          this option is ‘TRUE’, the value ‘""""’ represents a single
          quote, ‘\"’.

col_names: Either ‘TRUE’, ‘FALSE’ or a character vector of column
          names.

          If ‘TRUE’, the first row of the input will be used as the
          column names, and will not be included in the data frame. If
          ‘FALSE’, column names will be generated automatically: X1,
          X2, X3 etc.

          If ‘col_names’ is a character vector, the values will be used
          as the names of the columns, and the first row of the input
          will be read into the first row of the output data frame.

          Missing (‘NA’) column names will generate a warning, and be
          filled in with dummy names ‘X1’, ‘X2’ etc. Duplicate column
          names will generate a warning and be made unique with a
          numeric prefix.
<snipped>
```

This is the documentation for four `readr` commands: `read_delim`, `read_csv`, `read_csv2`, and `read_tsv`. They differ by the delimeter that they use to separate columns. For the most part, the defaults are what you will want. The only exception may be the `col_names` option, which defaults to TRUE indicating that your file has column headings. If our file didn't have headings, we'd use the following syntax:

```R
# Don't run this!
pcoa <- read_tsv(file="raw_data/baxter.thetayc.pcoa.axes")
```

These reading functions are pretty smart and can generally figure out the type of data that is in each column.

### Activity 1
Pretend that the data we want is actually on the second page of the `data/baxter.metadata.xlsx` workbook. Can you rewrite the `read_excel` command to read that page?

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">
```R
metadata <- read_excel(path="raw_data/baxter.metadata.xlsx", sheet=2)
```
</div>


### Activity 2
Open one of the spreadsheets where you keep the metadata for your project

* What do you see in your spreadsheet that might cause problems?
* How would you want to organize your metadata to make it easier to use with R?
* Look at the formatting of your data. Are all of the dates consistently formatted? Do you use a consistent capitalization style? Do you use non-text information (e.g. color) to represent values?


The output of the read functions that are part of the `tidyverse` are a special type of data frame called a `tibble`. To back up a step, what is a data frame? A data frame can be thought of as a table where each row represents a different entity and each column represents a different aspect of that entity. For example, the `metadata` variable stores the value of a data frame where each row represents a different person and each column represents various attributes of those people whether its their subject identification number, weight, height, location, diagnosis, smoking status, etc. Each row has the same number of columns. If a piece of data is missing, then R will denote the value for that entity with the `NA` value. Got it? Moving on, a `tibble` is a special type of data frame that is a stripped down version of the `data.frame` structure that is core to R. Keeping with the `.` for `_` theme, `data_frame` can be used as an alias for `tibble`.

There are some special aspects of a `tibble` to be aware of. Perhaps most important is that there are no names on the rows. Not allowing names on the rows is a safety measure to protect you from some weird quirks in R. Another difference is when you enter the name of the data frame at the prompt, instead of having the entire data frame vomited at your screen, you get an abbreviated output:


```r
metadata
```

```
## # A tibble: 490 x 17
##     sample fit_result Site  Dx_Bin dx    Hx_Prev Hx_of_Polyps   Age Gender
##      <dbl>      <dbl> <chr> <chr>  <chr>   <dbl>        <dbl> <dbl> <chr> 
##  1 2003650       0    U Mi… High … norm…    0            1.00  64.0 m     
##  2 2005650       0    U Mi… High … norm…    0            1.00  61.0 m     
##  3 2007660      26.0  U Mi… High … norm…    0            1.00  47.0 f     
##  4 2009650      10.0  Toro… Adeno… aden…    0            1.00  81.0 f     
##  5 2013660       0    U Mi… Normal norm…    0            0     44.0 f     
##  6 2015650       0    Dana… High … norm…    0            1.00  51.0 f     
##  7 2017660       7.00 Dana… Cancer canc…    1.00         1.00  78.0 m     
##  8 2019651      19.0  U Mi… Normal norm…    0            0     59.0 m     
##  9 2023680       0    Dana… High … norm…    1.00         1.00  63.0 f     
## 10 2025653    1509    U Mi… Cance… canc…    1.00         1.00  67.0 m     
## # ... with 480 more rows, and 8 more variables: Smoke <dbl>,
## #   Diabetic <dbl>, Hx_Fam_CRC <dbl>, Height <dbl>, Weight <dbl>,
## #   NSAID <dbl>, Diabetes_Med <dbl>, stage <dbl>
```

The output gives me the first ten columns and the first ten rows of the data frame. You'll notice that at the top of the output, it tells us that there are 490 rows and 17 columns. The column headings for the 7 columns that weren't outputted are listed at the bottom of the output. It also indicates, that 480 rows were not included in the output. In addition, the output tells us what type of variable each column contains. For example, the `fit_result` column contains `dbl` or double precision numbers and the `dx` column contains `chr` or character values. You'll also notice that zero values have a lighter color and that the `NA` for the first value in the `Smoke` column is red. These are all meant to improve the visualization of the data.

### Activity 3
Compare the output from typing `metadata` at the prompt to the output of typing `as.data.frame(metadata)` at the prompt.



## Exploring our metadata
Let's dig into the metadata to think about how we'd like to use it to improve our scatter plot or perhaps visualize the variation in our cohort. Whenever we read in a data frame there are a few things to do get a handle on your data. First, as we've already done, entering the name of the data frame at the prompt will tell us a lot of information. We might also want to get access to those individual chunks of data


```r
nrow(metadata)
```

```
## [1] 490
```

```r
ncol(metadata)
```

```
## [1] 17
```

```r
dim(metadata)
```

```
## [1] 490  17
```

These three commands tell us the number of rows (`nrow`), columns (`ncol`), and both together (`dim`) in our metadata data frame. Let's find out the names of our columns


```r
colnames(metadata)
```

```
##  [1] "sample"       "fit_result"   "Site"         "Dx_Bin"      
##  [5] "dx"           "Hx_Prev"      "Hx_of_Polyps" "Age"         
##  [9] "Gender"       "Smoke"        "Diabetic"     "Hx_Fam_CRC"  
## [13] "Height"       "Weight"       "NSAID"        "Diabetes_Med"
## [17] "stage"
```

Are these column names informative? What type of information do you think each column might contain? If our data frame had names on the rows, we could get their value using the `rownames` command in a similar way. We can get a sense of the data frame using the `head` command, which returns the first 6 values of a variable or `tail`, which returns the last 6 values.


```r
head(metadata)
```

```
## # A tibble: 6 x 17
##    sample fit_result Site  Dx_Bin  dx    Hx_Prev Hx_of_Polyps   Age Gender
##     <dbl>      <dbl> <chr> <chr>   <chr>   <dbl>        <dbl> <dbl> <chr> 
## 1 2003650        0   U Mi… High R… norm…       0         1.00  64.0 m     
## 2 2005650        0   U Mi… High R… norm…       0         1.00  61.0 m     
## 3 2007660       26.0 U Mi… High R… norm…       0         1.00  47.0 f     
## 4 2009650       10.0 Toro… Adenoma aden…       0         1.00  81.0 f     
## 5 2013660        0   U Mi… Normal  norm…       0         0     44.0 f     
## 6 2015650        0   Dana… High R… norm…       0         1.00  51.0 f     
## # ... with 8 more variables: Smoke <dbl>, Diabetic <dbl>,
## #   Hx_Fam_CRC <dbl>, Height <dbl>, Weight <dbl>, NSAID <dbl>,
## #   Diabetes_Med <dbl>, stage <dbl>
```

```r
tail(metadata)
```

```
## # A tibble: 6 x 17
##    sample fit_result Site   Dx_Bin dx    Hx_Prev Hx_of_Polyps   Age Gender
##     <dbl>      <dbl> <chr>  <chr>  <chr>   <dbl>        <dbl> <dbl> <chr> 
## 1 3529653          0 Dana … Normal norm…    0            0     51.0 f     
## 2 3531650          0 Dana … Normal norm…    1.00         0     53.0 f     
## 3 3535650          0 U Mic… Adv A… aden…    0            1.00  75.0 m     
## 4 3537650          0 U Mic… Normal norm…    0            0     56.0 f     
## 5 3551650          0 Dana … Adeno… aden…    1.00         1.00  77.0 m     
## 6 3561650          0 U Mic… Normal norm…    0            0     51.0 f     
## # ... with 8 more variables: Smoke <dbl>, Diabetic <dbl>,
## #   Hx_Fam_CRC <dbl>, Height <dbl>, Weight <dbl>, NSAID <dbl>,
## #   Diabetes_Med <dbl>, stage <dbl>
```

We can also use the `glimpse` command to get an idea about the structure of a variable.


```r
glimpse(metadata)
```

```
## Observations: 490
## Variables: 17
## $ sample       <dbl> 2003650, 2005650, 2007660, 2009650, 2013660, 2015...
## $ fit_result   <dbl> 0, 0, 26, 10, 0, 0, 7, 19, 0, 1509, 0, 0, 0, 0, 0...
## $ Site         <chr> "U Michigan", "U Michigan", "U Michigan", "Toront...
## $ Dx_Bin       <chr> "High Risk Normal", "High Risk Normal", "High Ris...
## $ dx           <chr> "normal", "normal", "normal", "adenoma", "normal"...
## $ Hx_Prev      <dbl> 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0...
## $ Hx_of_Polyps <dbl> 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1...
## $ Age          <dbl> 64, 61, 47, 81, 44, 51, 78, 59, 63, 67, 65, 55, 7...
## $ Gender       <chr> "m", "m", "f", "f", "f", "f", "m", "m", "f", "m",...
## $ Smoke        <dbl> NA, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, ...
## $ Diabetic     <dbl> 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0...
## $ Hx_Fam_CRC   <dbl> 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0...
## $ Height       <dbl> 182, 167, 170, 168, 170, 160, 172, 177, 154, 167,...
## $ Weight       <dbl> 120, 78, 63, 65, 72, 67, 78, 65, 54, 58, 60, 90, ...
## $ NSAID        <dbl> 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0...
## $ Diabetes_Med <dbl> 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0...
## $ stage        <dbl> 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 0, 0, 0, 0, 0, 3, 0...
```

You'll commonly encounter numerical (`dbl`, `int`, or `num`), categorical (`fctr`), boolean (`lgl`), and text (`chr`) data. The `str` command will tell you the type of data you have in your variable.

Another function that is great for characterizing a data frame (or any type of variable) is `summary`.


```r
summary(metadata)
```

```
##      sample          fit_result         Site              Dx_Bin         
##  Min.   :2003650   Min.   :   0.0   Length:490         Length:490        
##  1st Qu.:2326158   1st Qu.:   0.0   Class :character   Class :character  
##  Median :2776662   Median :   0.0   Mode  :character   Mode  :character  
##  Mean   :2757494   Mean   : 236.3                                        
##  3rd Qu.:3155185   3rd Qu.: 102.5                                        
##  Max.   :3561650   Max.   :2964.0                                        
##                                                                          
##       dx               Hx_Prev        Hx_of_Polyps         Age       
##  Length:490         Min.   :0.0000   Min.   :0.0000   Min.   :29.00  
##  Class :character   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:52.00  
##  Mode  :character   Median :0.0000   Median :1.0000   Median :60.00  
##                     Mean   :0.2834   Mean   :0.6687   Mean   :60.28  
##                     3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:69.00  
##                     Max.   :1.0000   Max.   :1.0000   Max.   :89.00  
##                     NA's   :3        NA's   :1                       
##     Gender              Smoke           Diabetic        Hx_Fam_CRC    
##  Length:490         Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
##  Class :character   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
##  Mode  :character   Median :0.0000   Median :0.0000   Median :0.0000  
##                     Mean   :0.4587   Mean   :0.1166   Mean   :0.1694  
##                     3rd Qu.:1.0000   3rd Qu.:0.0000   3rd Qu.:0.0000  
##                     Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
##                     NA's   :6        NA's   :1                        
##      Height          Weight           NSAID         Diabetes_Med    
##  Min.   :  0.0   Min.   :  0.00   Min.   :0.0000   Min.   :0.00000  
##  1st Qu.:162.0   1st Qu.: 67.00   1st Qu.:0.0000   1st Qu.:0.00000  
##  Median :170.0   Median : 78.00   Median :0.0000   Median :0.00000  
##  Mean   :169.8   Mean   : 79.08   Mean   :0.2459   Mean   :0.08163  
##  3rd Qu.:177.0   3rd Qu.: 90.00   3rd Qu.:0.0000   3rd Qu.:0.00000  
##  Max.   :203.0   Max.   :193.00   Max.   :1.0000   Max.   :1.00000  
##  NA's   :1       NA's   :1        NA's   :2                         
##      stage       
##  Min.   :0.0000  
##  1st Qu.:0.0000  
##  Median :0.0000  
##  Mean   :0.5245  
##  3rd Qu.:0.0000  
##  Max.   :4.0000  
## 
```


### Activity 4
What do you notice about the output of running `glimpse(metadata)`? What types of data are there? Thinking about the list of data types outlined above, are there columns that are improperly formatted? Do the column names match the type of data in the column? Looking at the output of `summary(metadata)`, what do you notice about how the different data types were summarized?



## Cleaning our metadata
After a quick look at the metadata we can see that there are a few things that aren't quite right that we might want to fix. Some of the columns are the wrong type and some of the values in the data frame don't make sense. For example, the `sample` column is a `double` and it should be a `character`. Let's start by fixing the column types. There are multiple ways to do this, but it is probably easiest, in the long run, to use the `col_types` argument in `read_excel` and `read_tsv`. Unfortunately, they have slightly different syntax. For `read_excel` the `col_type` options are "skip", "guess", "logical", "numeric", "date", "text" or "list". We'll normally only use "logical", "numeric", "text", and "date".


```r
metadata <- read_excel(path="raw_data/baxter.metadata.xlsx",
		col_types=c(sample = "text", fit_result = "numeric", Site = "text", Dx_Bin = "text",
				dx = "text", Hx_Prev = "logical", Hx_of_Polyps = "logical", Age = "numeric",
				Gender = "text", Smoke = "logical", Diabetic = "logical", Hx_Fam_CRC = "logical",
				Height = "logical", Weight = "numeric", NSAID = "logical", Diabetes_Med = "logical",
				stage = "text")
	)
metadata
```

```
## # A tibble: 490 x 17
##    sample  fit_result Site  Dx_Bin dx    Hx_Prev Hx_of_Polyps   Age Gender
##    <chr>        <dbl> <chr> <chr>  <chr> <lgl>   <lgl>        <dbl> <chr> 
##  1 2003650       0    U Mi… High … norm… F       T             64.0 m     
##  2 2005650       0    U Mi… High … norm… F       T             61.0 m     
##  3 2007660      26.0  U Mi… High … norm… F       T             47.0 f     
##  4 2009650      10.0  Toro… Adeno… aden… F       T             81.0 f     
##  5 2013660       0    U Mi… Normal norm… F       F             44.0 f     
##  6 2015650       0    Dana… High … norm… F       T             51.0 f     
##  7 2017660       7.00 Dana… Cancer canc… T       T             78.0 m     
##  8 2019651      19.0  U Mi… Normal norm… F       F             59.0 m     
##  9 2023680       0    Dana… High … norm… T       T             63.0 f     
## 10 2025653    1509    U Mi… Cance… canc… T       T             67.0 m     
## # ... with 480 more rows, and 8 more variables: Smoke <lgl>,
## #   Diabetic <lgl>, Hx_Fam_CRC <lgl>, Height <lgl>, Weight <dbl>,
## #   NSAID <lgl>, Diabetes_Med <lgl>, stage <chr>
```

In contrast, if we used `read_tsv` the syntax would look like this (note that this won't run since you don't have `data/baxter.metadata.tsv`)

```R
metadata <- read_tsv(file="raw_data/baxter.metadata.tsv",
		col_types=cols(sample = col_character(), fit_result = col_double(), Site = col_character(),
				Dx_Bin = col_character(), dx = col_character(), Hx_Prev = col_logical(),
				Hx_of_Polyps = col_logical(), Age = col_integer(), Gender = col_character(),
				Smoke = col_logical(), Diabetic = col_logical(), Hx_Fam_CRC = col_logical(),
				Height = col_double(), Weight = col_double(), NSAID = col_logical(),
				Diabetes_Med = col_logical(), stage = col_character())
	)
```

This is a bit tedious, but once you've done it you won't need to do it again. Also we can see exactly how we have recast the various columns to the correct format. I would ***strongly discourage*** editing the original metadata file to correct these problems. For example, you could do a `find-all-replace-all` to change `0` values in the "Diabetic" column to `FALSE` and the `1` values to `TRUE`. In the long run, this is likely to create more problems than it solves. **Your raw data should stay raw**. This is an advantage of using a function like `read_excel` - my collaborator can send me their workbook and I can use it as they gave it to me without mucking it up. Using the data munging procedures we're in the midst of, I can programmatically change the file without changing the version I have on my hard drive. This allows me to always know the provenience of my data.

Now that we have the types of variables correct, let's re-run the summary function to see how things look

```R
summary(metadata)
```

Take a moment to look at the columns represented in your data frame and the information presented below the column names. Do all of the values seem reasonable? Need a hint? Check out the information below "Height" and "Weight". Think someone could weight 0 kg or be 0 cm tall? I think those should instead be `NA`. To look at and manipulate an individual column we have three options:

```R
metadata[["Height"]]
metadata$Height
metadata[[13]]
```

The first two options are pretty solid, the third option is a bit of a hassle since it requires us to count columns. Whichever approach you select, stick with it and be consistent in your coding. These commands pulls out a column from the data frame and converts it into a vector. We'll learn more about vectors later. For now, think of this as a column. Just like we saw how we could update our `p` variable when adding layers to our scatter plot by using the `<-` operator, we can update our columns this way as well. The `dplyr` package, which is one of the core package within the tidyverse, has a useful function called `na_if`. If it finds a value we specify in the vector, it will convert it to an `NA`.


```r
metadata[["Height"]] <- na_if(metadata[["Height"]], 0)
metadata[["Weight"]] <- na_if(metadata[["Weight"]], 0)
```

Running `summary(metadata)` again, we see that the ranges for the "Height" and "Weight" columns are more reasonable now. We'd like to look at the values for our columns that contain character values, but they're obfuscated. One way to check this out is with the `table` command


```r
table(metadata[["Site"]])
```

```
## 
##   Dana Farber   MD Anderson       Toronto    U Michigan U of Michigan 
##           120            95           168           106             1
```

```r
table(metadata[["Dx_Bin"]])
```

```
## 
##          Adenoma      Adv Adenoma           Cancer          Cancer. 
##               89              109              119                1 
## High Risk Normal           Normal 
##               50              122
```

```r
table(metadata[["dx"]])
```

```
## 
## adenoma  cancer  normal 
##     198     120     172
```

```r
table(metadata[["Gender"]])
```

```
## 
##   f   m 
## 243 247
```

```r
table(metadata[["stage"]])
```

```
## 
##   0   1   2   3   4 
## 370  39  35  36  10
```

Notice anything weird here? Yup. In the "Site" column, it looks like our collaborator used "U of Michigan" for one subject, but "U Michigan" for all of the others. We need to fix this. We can use the `dplyr` function `recode` to make this easy...


```r
metadata[["Site"]] <- recode(.x=metadata[["Site"]], "U of Michigan"="U Michigan")
table(metadata[["Site"]])
```

```
## 
## Dana Farber MD Anderson     Toronto  U Michigan 
##         120          95         168         107
```

### Activity 5
You should notice that in the "Dx_Bin" column there is a subject with the value "Cancer." rather than "Cancer". Using `recode`, can you fix this value?

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">

```r
metadata[["Dx_Bin"]] <- recode(.x=metadata[["Dx_Bin"]], "Cancer."="Cancer")
table(metadata[["Dx_Bin"]])
```

```
## 
##          Adenoma      Adv Adenoma           Cancer High Risk Normal 
##               89              109              120               50 
##           Normal 
##              122
```
</div>


### Activity 6
It might be obvious to us what is contained in the "Gender" column - "f" and "m" are the only two values. What if we wanted to make the values a little more meaningful and have them read as "female" and "male"? Write a recode function(s) to convert the single character to the longer name. Confirm that you get the correct result

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">

```r
metadata[["Gender"]] <- recode(.x=metadata[["Gender"]], "m"="male")
metadata[["Gender"]] <- recode(.x=metadata[["Gender"]], "f"="female")

table(metadata[["Gender"]])
```

```
## 
## female   male 
##    243    247
```
</div>





## Cleaning up column names

If we look back at our column names in the `metadata` data frame, you'll notice that some names are in title case (e.g. "Hx_Prev") and others are in all lower case (e.g. "fit_result"). Also, some of the column names may not make sense to you if you aren't a clinican (e.g. "Hx_Prev"). You may have also noticed that our "Gender" column has data regarding the subject's sex, not gender. Let's see how we can fix these issues to make using the data frame easier.

As I mentioned above, there are two problems with the name "Hx_Prev" - the capitalization is inconsistent with the other columns and it may not be immediately clear what "Hx_Prev" means. We have many options for how to name things. "Hx_Prev" could be written as "HxPrev", "hxPrev", "hx_prev", "hx.prev", "previous_history", etc. It can get confusing to remember which column headings are capitalized and which are not. The general preference in the R world is to use lowercase lettering and to separate words in a name with an underscore (i.e. `_`). This is called "snake case". Having a consistent capitalization strategy may seem a bit pedantic, but it makes it easier to keep your names straight when you don't have to worry about capitalization. The preference would be to change names like "Site" and "Hx_Prev" to "site" and "hx_prev". We can convert the column names to lower case using the `rename_all` function in the `dplyr` package with the `tolower` function. Conversely, if you wanted everything in all caps, you could use the `toupper` function


```r
metadata <- rename_all(.tbl=metadata, .funs=tolower)
metadata
```

```
## # A tibble: 490 x 17
##    sample  fit_result site  dx_bin dx    hx_prev hx_of_polyps   age gender
##    <chr>        <dbl> <chr> <chr>  <chr> <lgl>   <lgl>        <dbl> <chr> 
##  1 2003650       0    U Mi… High … norm… F       T             64.0 male  
##  2 2005650       0    U Mi… High … norm… F       T             61.0 male  
##  3 2007660      26.0  U Mi… High … norm… F       T             47.0 female
##  4 2009650      10.0  Toro… Adeno… aden… F       T             81.0 female
##  5 2013660       0    U Mi… Normal norm… F       F             44.0 female
##  6 2015650       0    Dana… High … norm… F       T             51.0 female
##  7 2017660       7.00 Dana… Cancer canc… T       T             78.0 male  
##  8 2019651      19.0  U Mi… Normal norm… F       F             59.0 male  
##  9 2023680       0    Dana… High … norm… T       T             63.0 female
## 10 2025653    1509    U Mi… Cancer canc… T       T             67.0 male  
## # ... with 480 more rows, and 8 more variables: smoke <lgl>,
## #   diabetic <lgl>, hx_fam_crc <lgl>, height <lgl>, weight <dbl>,
## #   nsaid <lgl>, diabetes_med <lgl>, stage <chr>
```

We can use the `rename` function in the `dplyr` package to rename specific column names, similar to how we used the `recode` function to correct the data entry typos. Let's change our column names with "hx" in them to "history" and "dx" in them to "diagnosis"


```r
metadata <- rename(.data=metadata,
		previous_history=hx_prev,
		history_of_polyps=hx_of_polyps,
		family_history_of_crc=hx_fam_crc,
		diagnosis_bin=dx_bin,
		diagnosis=dx)
```

### Activity 7
As was mentioned, the "gender" column contains the sex of each individual ("f" or "m"). Change our `rename` function to also include code to change the name of that column.

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">
```R
metadata <- rename(.data=metadata,
		previous_history=hx_prev,
		history_of_polyps=hx_of_polyps,
		family_history_of_crc=hx_fam_crc,
		diagnosis_bin=dx_bin,
		diagnosis=dx,
		sex=gender)
```
</div>

We'll stop here, but it's also worth noting that we might want to add units to some of our columns. For example, we might rename the "height" column to "height_cm". Although manipulating the column headings and to be lowercase or to be more clear is a matter of personal preference, it makes your analysis easier to implement. This is especially true if you have to pause the project for a few weeks or months (e.g. the paper goes out for review, you go on vacation, etc.). When you come back to it, you won't have to recall what "Hx" means. Making sure the values in the data frame are correct by removing typos (e.g. "U of Michigan") and ensuring they are properly bounded (e.g. no heights of zero) is critical to the validity of your analysis. I want to reemphasize the importance of leaving your raw data raw. Our manipulations of the `metadata` data frame have not altered `raw_data/baxter.metadata.xlsx`. Perhaps we would like to export the cleaned up data frame to share with others. Similar to the `read_tsv` function from the `readr` package, that package also contains a `write_tsv` function that we can use to write the cleaned data to a text file. Before we do this, we'll create a directory in our project directory called `processed_data`.


```r
dir.create("processed_data", showWarnings=FALSE)
write_tsv(x=metadata, path='processed_data/baxter.metadata.tsv')
```


### Activity 8
Now that we have the `metadata` data frame looking spiffy, we want to run the next line:

```R
pcoa_metadata <- inner_join(pcoa, metadata, by=c('group'='sample'))
```

This throws an error. It is complaining because the "group" column in our `pcoa` data frame contains integers and the "sample" column in our `metadata` data frame contains characters. To merge these using `inner_join`, we need them to both be characters. Can you think of how to change the "sample" column from `meatdata` to be characters? Test your solution by creating the `pcoa_metadata` data frame

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">

```r
pcoa <- read_tsv(file="raw_data/baxter.thetayc.pcoa.axes",
		col_types=cols(group=col_character())

pcoa_metadata <- inner_join(pcoa, metadata, by=c('group'='sample'))
```

```
## Error: <text>:4:1: unexpected symbol
## 3: 
## 4: pcoa_metadata
##    ^
```
</div>


Because we've been keeping track of all of our commands we have a transcript of what we've done to the data. Let's rewrite that initial code chunk to have all of the processing steps together. We need to remember to update our column names in our new code:


```r
library(tidyverse)
library(readxl)

pcoa <- read_tsv(file="raw_data/baxter.thetayc.pcoa.axes",
		col_types=cols(group=col_character())
	)

metadata <- read_excel(path="raw_data/baxter.metadata.xlsx",
		col_types=c(sample = "text", fit_result = "numeric", Site = "text", Dx_Bin = "text",
				dx = "text", Hx_Prev = "logical", Hx_of_Polyps = "logical", Age = "numeric",
				Gender = "text", Smoke = "logical", Diabetic = "logical", Hx_Fam_CRC = "logical",
				Height = "logical", Weight = "numeric", NSAID = "logical", Diabetes_Med = "logical",
				stage = "text")
	)
metadata[["Height"]] <- na_if(metadata[["Height"]], 0)
metadata[["Weight"]] <- na_if(metadata[["Weight"]], 0)
metadata[["Site"]] <- recode(.x=metadata[["Site"]], "U of Michigan"="U Michigan")
metadata[["Dx_Bin"]] <- recode(.x=metadata[["Dx_Bin"]], "Cancer."="Cancer")
metadata[["Gender"]] <- recode(.x=metadata[["Gender"]], "m"="male")
metadata[["Gender"]] <- recode(.x=metadata[["Gender"]], "f"="female")

metadata <- rename_all(.tbl=metadata, .funs=tolower)
metadata <- rename(.data=metadata,
		previous_history=hx_prev,
		history_of_polyps=hx_of_polyps,
		family_history_of_crc=hx_fam_crc,
		diagnosis_bin=dx_bin,
		diagnosis=dx,
		sex=gender)

dir.create("processed_data", showWarnings=FALSE)
write_tsv(x=metadata, path='processed_data/baxter.metadata.tsv')

pcoa_metadata <- inner_join(pcoa, metadata, by=c('group'='sample'))

ggplot(pcoa_metadata, aes(x=axis1, y=axis2, color=diagnosis)) +
	geom_point(shape=19, size=2) +
	scale_color_manual(name=NULL,
		values=c("blue", "red", "black"),
		breaks=c("normal", "adenoma", "cancer"),
		labels=c("Normal", "Adenoma", "Cancer")) +
	coord_fixed() +
	labs(title="PCoA of ThetaYC Distances Between Stool Samples",
		x="PCo Axis 1",
		y="PCo Axis 2") +
	theme_classic()

ggsave("ordination.pdf")
```

<img src="assets/images/02_data_frames//unnamed-chunk-19-1.png" title="plot of chunk unnamed-chunk-19" alt="plot of chunk unnamed-chunk-19" width="504" />
