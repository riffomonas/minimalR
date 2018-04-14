

Let's take a brief aside to re-factor our plotting code. Take a look at what we have here

```{r, fig.show='hide'}
plot(meta_alpha$shannon~meta_alpha$Age, xlim=c(0,90), ylim=c(0,5), xlab="Age (years)",
		 ylab="Shannon Diversity Index", col=dx_color[as.character(meta_alpha$dx)], pch=19)
```

There's a subtle change here, do you see it? The output is the same, but in this code we used a `~`. Numerous commands in R will allow us to use the `~`. This should be read as "shannon is explained by age" or "our y-axis variable is explained by our x-axis variable". The significance isn't so obvious in this example. By doing this, however, we can use the `data` argument to simplify our code.

```{r}
plot(shannon~Age, data=meta_alpha, xlim=c(0,90), ylim=c(0,5), xlab="Age (years)",
		 ylab="Shannon Diversity Index", col=dx_color[as.character(dx)], pch=19)
```

Again, we've got the same output, but simpler code.

### Activity 4
Generate a new plot where you plot each patient's number of observed OTUs (Sobs) as a function of the fit result. Color each point by their gender and select the plotting symbol based on whether they smoke. Use the `~` approach with the `data` argument.

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">

```{r}
sex_color <- c(m="red", f="blue")
sex_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result",
		 ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=sex_symbol[Smoke+1])
```

</div>

Now we've got a couple colors and a couple plotting symbols. Our readers might like to know what these points represent! Let's make a legend. We do this with the legend command. To build a legend, we'll need to figure out a few things. First, we need to generate different plotting symbol and color combinations. Second, we need to connect those combinations to a description. Finally, we need to find a good place to put the legend. Unfortunately, as we tinker, we will need to rebuild the plot and place a new legend on top of it. Let's get going.

```{r}
sex_color <- c(m="red", f="blue")
sex_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result",
		 ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=sex_symbol[Smoke+1])
legend("bottomright", legend=c('Female smoker','Male smoker', 'Female non-smoker',
															 'Male non-smoker'))
```

Cool - we have the start of a legend! We have tentatively placed the legend in the "bottomright" and have added the legend text. Try replacing "bottomright" with "bottom", "bottomleft", "left", "topleft", "top", "topright", "right", or "center". Alternatively we could give the `legend` function x and y coordinates for the top left corner of the legend box.

```{r}
sex_color <- c(m="red", f="blue")
sex_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result",
		 ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=sex_symbol[Smoke+1])
legend(x=1000, y=100, legend=c('Female smoker','Male smoker', 'Female non-smoker',
															 'Male non-smoker'))
```

A useful function for selecting a location is the `locator` function. Run `locator(1)` and then go to the plotting window. You'll notice cross hairs, which look like an addition sign. Go ahead and click anywhere on your plot. Back in the terminal console you'll see x and y coordinates outputted. If you run `locator(2)` you can click twice to get two points. Go ahead and use the locator function to specify where you want the legend.

Alright, we know where we want the legend and what the text in the legend should say, now we need the plotting symbols and colors. Here we will use a `col` and `pch` vectors to specify the color and plotting symbol so that their order corresponds to the text in the legend.

```{r}
sex_color <- c(m="red", f="blue")
sex_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result",
		 ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=sex_symbol[Smoke+1])
legend(x=2000, y=100, legend=c('Female smoker','Male smoker', 'Female non-smoker', 'Male non-smoker'), pch=c(19,19,17,17), col=c("blue", "red","blue","red"))
```

We can make the legend text smaller or the plotting symbol larger by altering the pt.cex and cex values.

```{r}
sex_color <- c(m="red", f="blue")
sex_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result",
		 ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=sex_symbol[Smoke+1])
legend(x=2000, y=100, legend=c('Female smoker','Male smoker', 'Female non-smoker', 'Male non-smoker'), pch=c(19,19,17,17), col=c("blue", "red","blue","red"), pt.cex=1.5, cex=0.8)
```

### Activity 5
Revisit the ordination plot you generated in Activity 5 from Session 2 and generate a legend to accompany the plot.

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">
```{r}
sex_color <- c(f="red", m="blue")
dx_pch <- c(normal=17, adenoma=18, cancer=19)

plot(x=pcoa$axis1, y=pcoa$axis2, xlab="PCo Axis 1", ylab="PCo Axis 2",
		 xlim=c(-0.5, 0.5), ylim=c(-0.6, 0.4), pch=dx_pch[metadata$dx],
		 col=sex_color[as.character(metadata$Gender)], lwd=1, cex=1,
		 main="PCoA of ThetaYC Distances Between Stool Samples")

legend("bottomright", legend=c("Female, Normal", "Female, Adenoma", "Female, Cancer", "Male, Normal", "Male, Adenoma", "Male, Cancer"), pch=c(dx_pch, dx_pch), col=rep(sex_color, each=3))
```
</div>


Sometimes our plots have points that are well spread across the plotting window and it's impossible to find a clean place to put the legend. Putting the legend in the plotting window would cover your data or could confuse the viewer into thinking that the plotting symbols in the legend were data. This is why many favor putting the legend outside of the plotting window. To do this, we need to learn a little about how the space around the plot is formatted. Have you noticed that in our plots without a main title there is a lot of space at the top of the window? That's the margin. If we call `par()$mar` we can see the margin values. These seem a bit cryptic, but represent the number of lines between the axis and the edge of the window. The numbers start on the x-axis and go clockwise. We can call `par(mar=c(1,1,1,1))` to set all the margins to one line or we could call `par(mar=c(5,5,1,10))` to have a wide margin on the right side. Let's give this a shot.

```{r}
par(mar=c(5,5,1,10))
sex_color <- c(m="red", f="blue")
smoke_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result", ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=smoke_symbol[Smoke+1])
legend(x=2000, y=100, legend=c('Female smoker','Male smoker', 'Female non-smoker', 'Male non-smoker'), pch=c(19,19,17,17), col=c("blue", "red","blue","red"), pt.cex=1.5, cex=0.8)
```

Great. You'll notice that we saved the default value before changing the margins and then reset the values at the end of the code chunk. This is helpful to keep our settings consistent. Now let's use the `locator` function that we learned about to find a good place to put the legend in the right side margin. You'll see that the x values continue beyond the x-axis labels and that the y values are consistent with the y-axis values. To get this to work, we'll need to add the `xpd` argument to our legend command. This allows us to plot information outside of the normal plotting window.

```{r, collapse=TRUE}
par(mar=c(5,5,1,10))
sex_color <- c(m="red", f="blue")
smoke_symbol <- c(17, 19)
plot(sobs~fit_result, data=meta_alpha, xlim=c(0,3000), ylim=c(0, 400), xlab="Fit Result", ylab="Number of OTUs", col=sex_color[as.character(Gender)], pch=smoke_symbol[Smoke+1])
legend(x=3300, y=300, legend=c('Female smoker','Male smoker', 'Female non-smoker', 'Male non-smoker'), pch=c(19,19,17,17), col=c("blue", "red","blue","red"), pt.cex=1.5, cex=0.8, xpd=TRUE)
```

Before we leave this analysis, it would be nice to know whether the number of OTUs is correlated with the fit result. In R, we can use a Pearson, Spearman, or Kendall correlation analysis. We can do the correlation using either the `cor` or `cor.test` functions. We'll use the `cor.test` function because it has more interesting output. We'll also use the Spearman correlation because FIT result data are not normally distributed

```{r}
cor.test(meta_alpha$fit_result, meta_alpha$sobs, method="spearman")
```

We see that our correlation is `r c_t <- cor.test(meta_alpha$fit_result, meta_alpha$sobs, method="spearman"); format(c_t$estimate, digits=2)` and the P-value is `r format(c_t$p.value, digits=2)`, which is not significant. If we wanted to use the Pearson or Kendall correlations we would replace "spearman" with "pearson" (the default) or "kendall".


### Activity 6
Revisiting the figure from Activity 5, go ahead and put the legend in the right hand margin of the plotting window.

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">
```{r}
sex_color <- c(f="red", m="blue")
dx_pch <- c(normal=17, adenoma=18, cancer=19)

par(mar=c(5,5,2,10))
plot(x=pcoa$axis1, y=pcoa$axis2, xlab="PCo Axis 1", ylab="PCo Axis 2",
		 xlim=c(-0.5, 0.5), ylim=c(-0.6, 0.4), pch=dx_pch[metadata$dx],
		 col=sex_color[as.character(metadata$Gender)], lwd=1, cex=1,
		 main="PCoA of ThetaYC Distances Between Stool Samples")

legend(x=0.6, y=0.4, legend=c("Female, Normal", "Female, Adenoma", "Female, Cancer", "Male, Normal", "Male, Adenoma", "Male, Cancer"), pch=c(dx_pch, dx_pch), col=rep(sex_color, each=3), xpd=TRUE)
```
</div>


### Activity 7
Plot the relationship between each person's height and weight. What is the correlation between the two variables?

<input type="button" class="hideshow">
<div markdown="1" style="display:none;">

```{r}
plot(metadata$Weight~metadata$Height, xlab="Height (cm)", ylab="Weight (kg)")
cor.test(metadata$Weight, metadata$Height, method="spearman")
```

</div>


### Activity 8
Through the previous two sessions you've been developing your own scatter plot idea. At this point, you should know everything you need to plot your own data. Go for it!
