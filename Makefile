RMD = $(wildcard _rmd_files/*.Rmd)
MD = $(addsuffix .md,$(basename $(subst _rmd_files/,,$(RMD))))

print-%  :
	@echo $* = $($*)



%.md : _rmd_files/%.Rmd
	R -e 'library("ezknitr"); ezknit(file="$<", out_dir="./", keep_html=FALSE, fig_dir="assets/images/$(basename $@)")';

all : $(MD) $(RMD)

clean:
	rm $(MD)
