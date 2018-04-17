
If you did the last activity (ahem, go do it...) you'll see that I highlighted the fact that many of the values in our data frame contain "unclassified". Perhaps we'd like it to say "Unclassified Clostridiales". How can we get that to work? Instead of an unknown genus, let's try this out with an unknown family so that it is easier to generalize the problem. Here's how I'd think through the problem.

1. Pick the level I'm interested in (e.g. family)
2. Merge higher level taxonomic names with level of interest
3. If level of interest is "unclassified"
		* Trim off unclassifieds until we get to a real name
		* Reformat name to be "Unclassified <class name>"
4. If it isn't unclassified, then remove everything above the level of interest

Make sense? We can join columns with the `unite` function from the `dplyr` package telling it which columns to merge (`kingdom`, `phylum`, `class`, `order`, `family`), the name of the merged column (`taxonomy`) and what to separate them with (`;`). Like our outline above, let's break down the code in steps. First up, steps 1 and 2 where we merge the levels we're interested in

```{r}
taxonomy %>%
		unite(kingdom, phylum, class, order, family, col="taxonomy", sep=";") %>% #steps 1 & 2
		select(taxonomy)
```

Next, we will create a pattern that trims off the unclassified part and reformat name to be "Unclassified <class name>".

```{r}
taxonomy %>%
		unite(kingdom, phylum, class, order, family, col="taxonomy", sep=";") %>% #steps 1 & 2
		mutate(taxonomy=str_replace_all(taxonomy, pattern=".*;(.*);unclassifie.*", replacement="Unclassified \\1")) %>% #step 3
		select(taxonomy) %>% filter(grepl(taxonomy, pattern="unclassified"))

nuke all unclassifieds and replace with NA
x <- "Bacteria;Firmicutes;Clostridia;unclassified;unclassified"
x <- str_replace_all(x, pattern="unclassifie.*", replacement="Unclassified \\1")
str_replace_all(x, pattern=".*;(.*);unclassifie.*", replacement="Unclassified \\1")

```


This pattern may require a little thinking. The `.*;` component matches everything up to a `;`

```
read_tsv(file="raw_data/baxter.cons.taxonomy") %>%
		rename_all(tolower) %>%
		mutate(taxonomy=str_replace_all(string=taxonomy, pattern="\\(\\d*\\)", replacement="")) %>%
		mutate(taxonomy=str_replace_all(string=taxonomy, pattern="unclassified;", replacement="")) %>%
		mutate(taxonomy=str_replace_all(string=taxonomy, pattern=";$", replacement="")) %>%
		mutate(taxonomy=str_replace_all(string=taxonomy, pattern=".*;", replacement=""))
```
