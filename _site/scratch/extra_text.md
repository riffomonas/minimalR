We'd like to plot the median relative abundance plus the 95% confidence interval. We could calculate these values in one function call, but parsing the output is a pain. So we'll do it in three steps. To calculate the relative abundances at the 2.5 and 97.5 percentiles, we will create what's called an anonymous function. This is a fancy way of saying we'll create a function that doesn't have a name. See? Fancy.

```{r}
sig_perabund_median <- aggregate(sig_perabund, by=list(metadata$dx), median)
sig_perabund_lci <- aggregate(sig_perabund, by=list(metadata$dx), function(x)quantile(x, prob=0.025))
sig_perabund_uci <- aggregate(sig_perabund, by=list(metadata$dx), function(x)quantile(x, prob=0.975))
```

See how that worked? The `aggregate` function take a function in the third spot and because we also need to send `quantile` other arguments, we need to create a simple, one argument function that doesn't get named. Turning to the `barplot` function, you may recall that this takes a matrix as input. But `sig_relabund_mean` is a data frame. We can convert it to a matrix after removing the first column. We'll do this in one line
