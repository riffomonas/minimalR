RMD = $(wildcard *.Rmd)
HTML = $(subst Rmd,html,$(RMD))

print-%  :
	@echo $* = $($*)

%.html : %.Rmd
	R -e 'render("$<")'

all : $(HTML) $(RMD)

clean:
	rm *.html
