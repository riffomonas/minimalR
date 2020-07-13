---
layout: lesson
title: "Session 10: Faceting your figures"
output: markdown_document
---



## Learning objectives




```r
source("code/baxter.R")

alpha <- read_tsv(file="raw_data/baxter.groups.ave-std.summary",
		col_types=cols(group = col_character())) %>%
	filter(method=='ave') %>%
	select(group, sobs, shannon, invsimpson, coverage)
metadata <- get_metadata()
meta_alpha <- inner_join(metadata, alpha, by=c('sample'='group'))
```


meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_grid(.~metric)

meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_grid(metric~.)

meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_grid(sex~metric)



meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_wrap(~metric)

meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_wrap(~metric, scales="free")

meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_wrap(sex~metric, scales="free")



meta_alpha %>% pivot_longer(c(shannon, invsimpson, sobs, coverage), names_to="metric", values_to="value") %>% ggplot(aes(x=diagnosis, y=value)) + geom_boxplot() + facet_wrap(sex~metric, scales="free", nrow=2)



#customize labels for panels
http://ggplot2.tidyverse.org/reference/labeller.html
http://ggplot2.tidyverse.org/reference/as_labeller.html
http://ggplot2.tidyverse.org/reference/labellers.html
capitalize <- function(string) {
  substr(string, 1, 1) <- toupper(substr(string, 1, 1))
  string
}
p2 <- ggplot(msleep, aes(x = sleep_total, y = awake)) + geom_point()
p2 + facet_grid(vore ~ conservation, labeller = labeller(vore = capitalize))

conservation_status <- c(
  cd = "Conservation Dependent",
  en = "Endangered",
  lc = "Least concern",
  nt = "Near Threatened",
  vu = "Vulnerable",
  domesticated = "Domesticated"
)
p2 + facet_grid(vore ~ conservation, labeller = labeller(
  .default = capitalize,
  conservation = conservation_status
))


#ordination with gray background points and colored top points
ggplot(mpg, aes(displ, hwy)) +
  geom_point(data = transform(mpg, class = NULL), colour = "grey85") +
  geom_point() +
  facet_wrap(~class)



# gganimate



# cowplot
