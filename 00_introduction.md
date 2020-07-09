---
layout: lesson
title: "Session 0: Introduction"
output: markdown_document
---

## Content
* Philosophy behind these instructional materials
* Why R?
* Introduction to R
* Getting settled in RStudio
* Setting up a project





## Philosophy
I have never taken a course or workshop in using R. I've read a lot of books on how to program with R. To be honest, I'm not sure how much they helped. I learned R by taking a single script that I wrote to create a scatter plot and modifying it or "hacking it" to get it to do what I wanted. If I ran into a problem, I would either google the error message or the question I was trying to answer. As I asked around, I learned that most people learned R by hacking their way to success along with a lot of practice. That is the underlying philosophy of this series of lessons. Most programming books slowly build to something useful with silly examples along the way. The first code you will write in Lesson 1 will be the basis of every other piece of code we write in these tutorials. We will start with working code for a plot that could be published and hack it until we have a plot showing which taxa are associated with health or disease.

I suspect that you will understand the first chunk of code we write. We will strive for readable code that is easy to understand. That being said, just because you suspect that the `geom_point` function will add points to a plot, doesn't mean that you know how to use `geom_point` or that you would know how to make a bar chart. Calmly accept your ignorance and know that all will be explained eventually. Learning experts have found that we do not learn best by taking on a topic and beating it to death until we've mastered it. Rather, we learn best when we learn something partially, move on to something else that we also learn partially, but can fold in the previous knowledge to help us improve our partial knowledge of the earlier topic. It's kind of like taking steps forward in a dark room only to get to the end and see that you knew the path all the way along. This is the approach that we will be taking with these lessons. My goal is not to provide a reference on R or to necessarily document every nook and cranny of the language and its myriad packages. I will empower you to do that.

The final philosophical point I will make is that I believe it is important to eat your own dog food as an educator. Everything I teach, is how I want to code and how I want those that work for me to code. There is definitely always room for improvement, but be confident that I'm not trying to sell you on something that I do not use myself. That being said, although I don't claim that the plots we'll make are works of aRt, I do think that they're pretty close to being publication quality. Why make a crappy plot, when you could make a good one that puts your work in the best possible light?

If you notice a bug, something that is unclear, have an idea for a better approach, or want to see something added, please file an issue or, even better, a pull request at the project's [GitHub repository](https://github.com/riffomonas/minimalR).

## Why R
If you're looking for some big "pound your chest" explanation for why you should learn R, then you're looking in the wrong place. I know R. That's why I teach R. Why did I learn R? There were people around me that new R and I knew I could depend on them to help me learn R if I ran into any problems. Less important than which language you should learn is that you learn *A* language. Any language, really.

The way I see it there are several credible languages if you are a scientist: R, Python, C/C++, Java. R and Python are "high level" languages that have a lot of built in goodies to make your life easy. As you'll see, it's pretty easy to build a graph or to calculate a mean in R (and python). These languages are engineered to make it easier on the programmer than the person running the code. In contrast, C/C++ and Java are not as easy to program, but are far more efficient and run blazing fast. You'll hear about others like Julia, Ruby, or Perl. These aren't quite mainstream for biologists or aren't fully developed yet or are past their sell by date. Unless you have needs for high performance, I'd probably stay away from C/C++ and Java isn't really all that high performance. If you need the speed of C++ you can write C++ in R.

This leaves you to chose between R and Python. You can google "Should I learn R or Python" and you'll get screed after screed telling you why one language is the best. Do not read these. They're next to worthless and smack of all sorts of machismo. I block accounts on Twitter that go off on R vs. Python screeds. I know R's warts and I know that Python could possibly cure these warts. But I also know that Python has its own warts. Rather than carry the cognitive baggage of learning both, I do what I need in R. At least a few times a year I tell myself I should learn Python to know it, but when it comes to doing it, I'm just not sold. To be honest, to really appreciate the differences between the languages you probably need a fair bit more experience than someone that is reading this. Note that someone else could/should easily rewrite this paragraph switching R and Python.

But really! What should you learn? Depends. What does your research group use? What do your collaborators use? What do the people around you use? If you have a problem, who are you going to get help from? For me, the answers to these questions were generally: R. Again, it's more important that you learn your first language than which language you learn. Master your first language and then start noodling with others. I always cringe when I see someone encouraging a novice to learn other languages. It can only sow confusion and frustration. Since you're here, I suspect someone has encouraged you to learn R or that your local community has some R chops. Welcome! I want to challenge you to not just use your community to help you, but to also nourish your community to help it grow.


## What you need to do these tutorials...
* [R](https://cloud.r-project.org/)
* [RStudio](https://www.rstudio.com/products/rstudio/download/#download)
* [Raw data files](https://github.com/riffomonas/raw_data/archive/0.1.zip). This will download a directory called `raw_data-X.X` where the "X.X" is the version number. Remove the `-X.X` and make sure the directory is uncompressed. ***This is super important!***


## Customizing RStudio
There are many ways to customize RStudio. You can find the options by going to the Preferences window. If you are using windows you can get to the Preferences window by going Tools->Global Options. Here is a screenshot of how to do it for Mac OS X. The method should be pretty similar for people working on a Windows computer.

<img class="center" src="assets/images/launch_preferences.png" width="40%">

In the first tab, "General", you should have something like this.

<img class="center" src="assets/images/general_preferences_tab.png" width="40%">

You don't want any of the boxes to be checked except to be notified of RStudio updates, these are especially problematic:
* Restore .RData into workspace at startup
* Save workspace to .RData on exit (toggle should say "Never")
* Always save history

Once you've got everything checked/unchecked the way you want it, go ahead and click "Apply" and then "OK"


## Installing packages

There's a lot of functionality built into R. The beauty of it being an open source resource is that anyone can add to it to expand it's functionality or to improve how you work with the existing functionality. This is done through packages. Some day, you might make your own package! We will use several R packages throughout our Code Clubs. The one we'll use the most is called `tidyverse`. We'll be talking a lot about this package as we go along. But for now, we need to install this package. In the lower right panel of RStudio, select the "Package" tab. You'll get something that looks like this:

<img class="center" src="assets/images/package_tab.png" width="50%">

In the search window, type in "tidyverse" (without the quotes). If it isn't already installed, you won't see it. If it is installed, it will be listed. The package isn't installed on my computer.

<img class="center" src="assets/images/tidyverse_search_v1.png" width="50%">

If it isn't installed on your computer either, go ahead and click the Install button and type "tidyverse" into the "Packages" window:

<img class="center" src="assets/images/tidyverse_install_window.png" width="50%">

Once you press the "Install" button, the dialog will close and RStudio will install the package. You'll notice a couple things have happened. In the Packages tab in the lower right panel, you now see the "tidyverse" package is there. You'll also notice that in the lower left corner that R ran the command `install.packages("tidyverse")`.

<img class="center" src="assets/images/install_packages_tidyverse.png" width="50%">

Finally, to make all of the tidyverse goodness available as we go through the tutorials, you can either click the small square next to "tidyverse" in the "Packages" tab or you can run `library(tidyverse)` in the console tab in the lower left panel of RStudio.

<img class="center" src="assets/images/library_tidyverse.png" width="50%">

Some things may happen...
* While loading the tidyverse library or during installation, it may ask if you want to install from source, go ahead and type "Yes" at the prompts.
* You might run into an error message that says, "there is no package called ‘Rcpp’". It might be Rcpp and/or another package that it complains about. Try to replicate the steps for installing the tidyverse package, but with Rcpp and any other packages it complains about.
* If you are on a Mac, to install these tools, you will need to click on the "Terminal" tab an enter `xcode-select --install `. Once that is done, go back to the "Console" tab. Then try to install the packages it is complaining about.
* If you've run into problems and and reinstalled the dependencies, re-run `install.packages(tidyverse)` and repeat the `library(tidyverse)` command. You may need to restart RStudio. You should get something that looks like

```R
> library(tidyverse)
── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
✔ ggplot2 3.2.1     ✔ purrr   0.3.3
✔ tibble  2.1.3     ✔ dplyr   0.8.4
✔ tidyr   1.0.2     ✔ stringr 1.4.0
✔ readr   1.3.1     ✔ forcats 0.5.0
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
```


## R Scripts

We'll quickly get to a point where we don't want to retype multiple lines of code over and over. We can create R scripts that hold lines of code that R Studio will run for us. We can open a new R script by choosing the File menu, then the New File menu, and finally the R Script option. Alternatively, you could click on the icon that contains a white page with a green plus sign on it. I've put a red circle around it in the screen shot below

<img class="center" src="assets/images/new_script.png" width="50%">

Once you select "R script", a new panel will open in RStudio.

<img class="center" src="assets/images/script_window.png" width="50%">

That upper right panel is where you can type in code. Go ahead and copy and paste the following code into your new R script

```R
library(tidyverse)

read_csv("https://raw.githubusercontent.com/fivethirtyeight/data/master/comma-survey/comma-survey.csv") %>%
	rename(data=`How would you write the following sentence?`) %>%
	mutate(data=recode(data,
		`Some experts say it's important to drink milk, but the data are inconclusive.` = "Plural",
		`Some experts say it's important to drink milk, but the data is inconclusive.` = "Singular")
	) %>%
	count(data) %>%
	drop_na() %>%
	mutate(percentage = 100 * n/sum(n)) %>%
	ggplot(aes(x=data, y=percentage, fill=data)) +
		geom_col(show.legend=FALSE) +
		labs(x=NULL,
			y="Percentage of respondents",
			title="Is the word 'data' plural or singular?") +
		theme_classic()
```

Go ahead and save this as `test_script.R`. You should have something like this

<img class="center" src="assets/images/final_script.png" width="50%">


There are several ways to run this script. You could copy and paste all the code to the console window below. An easier way would be to click "Source", and "Source with Echo". There are a few other ways to run the code in the script in your console, but this will serve us well for now...

<img class="center" src="assets/images/source_script.png" width="50%">

This will run your code in the console window below and will pop out your plot in the lower right corner. Viola! If everything is set up correctly, you should have a plot that looks like mine.

<img class="center" src="assets/images/final_output.png" width="75%">

If you don't get this, make sure you installed the `tidyverse` package as described above and then make sure you copy and pasted everything from the code block above into a clean R script file.


## Set up our minimalR project...
* In your home directory or desktop create a directory called `minimalR`
* Move your decompressed `raw_data` directory into `minimalR`. There should only be one thing in `minimalR`, which is the `raw_data` directory. If you look at your Finder window or Window Explorer window, you should have something that looks like this when `raw_data` is expanded

<img src="assets/images/folder_setup.png" width="50%">

* To make life easier, you should start with RStudio. Open `RStudio` and do "File->New Project->Existing Directory".

<img src="assets/images/file_menu.png" width="50%">

* Once you're in the "Create Project" dialog click on the "Existing Directory" link.

<img src="assets/images/new_project.png" width="50%">


* Use the "Browse" button to find `minimalR`. Once you're there (you should only see `raw_data` in the directory), select open.

<img src="assets/images/browse_to_project.png" width="50%">

* My copy of `minimalR` is on the desktop and it lists my "Project working directory" as `~/Desktop/minimalR`. Click "Create Project"

<img src="assets/images/create_project.png" width="50%">

* In the lower right corner of the RStudio program window you will see that the "Files" tab is selected. In the panel it will have a file called `minimalR.Rproj` and a directory called `raw_data`.

<img src="assets/images/files_panel.png" width="50%">

* Quit RStudio
* Use your finder to navigate to your `minimalR` directory
* Double click on `minimalR.Rproj`. This is probably the quickest way to have RStudio open up in your desired working directory.

<img src="assets/images/start_w_project.png" width="50%">


## My setup
If you run `sessionInfo` at the console, you will see the version of R and the packages you have installed and attached (more about what this all means later). Here's what mine looks like.




```r
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-apple-darwin17.0 (64-bit)
## Running under: macOS Mojave 10.14.6
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRblas.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] forcats_0.5.0   stringr_1.4.0   dplyr_0.8.5     purrr_0.3.4    
##  [5] readr_1.3.1     tidyr_1.1.0     tibble_3.0.1    ggplot2_3.3.0  
##  [9] tidyverse_1.3.0 knitr_1.28      ezknitr_0.6    
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.4.6      cellranger_1.1.0  pillar_1.4.4      compiler_4.0.2   
##  [5] dbplyr_1.4.4      R.methodsS3_1.8.0 R.utils_2.9.2     tools_4.0.2      
##  [9] lubridate_1.7.8   jsonlite_1.6.1    evaluate_0.14     lifecycle_0.2.0  
## [13] nlme_3.1-148      gtable_0.3.0      lattice_0.20-41   pkgconfig_2.0.3  
## [17] rlang_0.4.6       reprex_0.3.0      cli_2.0.2         rstudioapi_0.11  
## [21] DBI_1.1.0         haven_2.2.0       xfun_0.14         withr_2.2.0      
## [25] xml2_1.3.2        httr_1.4.1        fs_1.4.1          hms_0.5.3        
## [29] generics_0.0.2    vctrs_0.3.0       grid_4.0.2        tidyselect_1.1.0 
## [33] glue_1.4.1        R6_2.4.1          fansi_0.4.1       readxl_1.3.1     
## [37] modelr_0.1.8      blob_1.2.1        magrittr_1.5      backports_1.1.7  
## [41] scales_1.1.1      ellipsis_0.3.1    rvest_0.3.5       assertthat_0.2.1 
## [45] colorspace_1.4-1  stringi_1.4.6     munsell_0.5.0     broom_0.5.6      
## [49] crayon_1.3.4      R.oo_1.23.0
```
