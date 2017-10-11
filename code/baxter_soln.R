library("dplyr")


# This function calculates a BMI value. Note that it assumes
# the person's weight is in kg and their height is in cm. Probably
# want to add code later to make sure the inputted height and
# weight values make sense
get_bmi <- function(weight_kg, height_cm){
  height_m <- height_cm/100
  bmi <- weight_kg / height_m ^2
  return(bmi)
}


# This function takes in a bmi value and based on NIH recommendations
# returns the BMI category that the value falls within
get_bmi_category <- function(bmi){
  category <- ifelse(bmi >= 30, "obese",
                     ifelse(bmi >=25, "overweight",
                            ifelse(bmi >= 18.5, "normal", "underweight")))
  return(category)
}


# this function takes in a BMI value and reports whether the individual is obese
is_obese <- function(bmi){
  get_bmi_category(bmi) == "obese"
}


get_meta <- function(){
	metadata <- read.table(file="data/baxter.metadata.tsv", header=T, sep='\t', stringsAsFactors=F)
	metadata$sample <- as.character(metadata$sample)
	metadata$Hx_Prev <- as.logical(metadata$Hx_Prev)
	metadata$Smoke <- as.logical(metadata$Smoke)
	metadata$Diabetic <- as.logical(metadata$Diabetic)
	metadata$Hx_Fam_CRC <- as.logical(metadata$Hx_Fam_CRC)
	metadata$Hx_of_Polyps <- as.logical(metadata$Hx_of_Polyps)

	metadata$NSAID <- as.logical(metadata$NSAID)
	metadata$Diabetes_Med <- as.logical(metadata$Diabetes_Med)
	metadata$stage <- as.factor(metadata$stage)

	metadata[metadata$Height == 0 & !is.na(metadata$Height), "Height"] <- NA
	metadata[metadata$Weight == 0 & !is.na(metadata$Weight), "Weight"] <- NA

	metadata$BMI <- get_bmi(weight_kg = metadata$Weight, height_cm = metadata$Height)
	metadata$BMIcat <- get_bmi_category(metadata$BMI)
	metadata$is_obese <- is_obese(metadata$BMI)

	return(metadata)
}


get_meta_alpha <- function(){
	metadata <- get_meta()

	alpha <- read.table(file="data/baxter.groups.ave-std.summary", header=T)
	alpha$group <- as.character(alpha$group)
	alpha_mean <- alpha[alpha$method == 'ave', ]

	meta_alpha <- inner_join(metadata, alpha_mean, by=c("sample"="group"))
}


get_meta_pcoa <- function(){
	metadata <- get_meta()

	pcoa <- read.table(file="data/baxter.thetayc.pcoa.axes", header=T)
	pcoa$group <- as.character(pcoa$group)

	meta_pcoa <- inner_join(metadata, pcoa, by=c("sample"="group"))
}


dx_color <- c(normal="black", adenoma="blue", cancer="red")
dx_pch <- c(normal=17, adenoma=18, cancer=19)
sex_color <- c(f="red", m="blue")
sex_symbol <- c(17, 19)
