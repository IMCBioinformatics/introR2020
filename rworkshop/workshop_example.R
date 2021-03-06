library(ggplot2)
library(tidyverse)

# Define vectors
d <- c(1,2,3,4,5,6,7)
e <- 8:14
f <- "Myplot"

# Plot example
plot(d,e,main=f)
plot(e,d)

#Creating Objects
weight_kg <- 65
weight <-55
str(weight_kg)
print(f,quote = F)
sqrt(weight_kg)
dummy<-5.6666
dummy_X<-4.6922
round(dummy_X,digits = 2)

# Data structures

x<-45
x<c(1,2,3,4)
x<-c("a","b","c")

x<-c(1,FALSE,TRUE)


## Vectors

pocket_money<-c(10,20,40)
animals<-c("mouse","rat","dog")
length(animals)
animals[1]
animals[2]
animals[3]
animals[4]

animals[1:2]

animals[1:3]

idx<-c(1,3)

animals[idx]

animals[c(1,3)]

animals<-c("mouse","rat","dog")
animals<-c(animals,"horse")

animals<-c("elephants",animals)

c(animals[5],animals[1],animals[3])

animals<-animals[-3]
animals[3]

animals[-c(2,3)]
animals[c(1,4)]

animals<-c(animals[1:2],"rat",animals[3:4])
animals<-c(animals[1],"birds",animals[c(4,3,5)])
## more subsetting

keep<-c(TRUE,FALSE,FALSE,TRUE,FALSE)

animals[keep]


weight_kg<-c(55,65,72)
keep<-weight_kg > 64
weight_kg[weight_kg > 72 & weight_kg < 100]

animals[animals=="birds"]

animals[animals %in% c("birds","dog","cat")]

"four" > "five"

# Missing

heights<-c(2,4,5,NA,6)

mean(x = heights,na.rm = TRUE)

is.na(heights)


heights[!is.na(heights)]


heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
heights


heights_withoutNA<-heights[!is.na(heights)]
median(heights_withoutNA)
median(heights,na.rm = T)

 length(heights_withoutNA)
 sum(heights_withoutNA >67)

### read in data

ecoli<-read.csv("data/Ecoli_metadata.csv")

library(tidyverse)
ecoli<-read.csv("Ecoli_metadata.csv")
read.delim(file = "Ecoli_metadata.csv")

ecoli_tidy<-read_csv(file = "Ecoli_metadata.csv")

head(ecoli)

ecoli[3,1]

ecoli[4,6]
ecoli[4,"run"]


read.csv(file = "Ecoli_metadata.csv",stringsAsFactors = T)

BMI <- data.frame(gender = c("male", "male", "female"), height = c(152, 171.5, 165), weight = c(81, 93, 78), age = c(42, 36, 26))

dim(BMI)

colnames(BMI)<-c("a","b","weight_kg","c")

result_dir<-"/Users/hena/projects/introR2020/"

bmi_file<-paste0(result_dir,"bmi.csv")

write.csv(x = BMI,file = bmi_file)

BMI$weight_kg
BMI[1]


plot(ecoli$cit)

ecoli$clade<-factor(ecoli$clade,levels = c("C1","C3","(C1,C2)","UC","unknown","N/A"))

#forcats


# Revision 


x=c(1,12,54,24,NA)
!is.na(x)
x[!is.na(x)]
dim(x)

BMI$gender


x=c(1,12,54,24,NA)



relevel(BMI$gender,ref = "male")


# Chapter7 tibbles


friends_data <- tibble(
    name = c("Nicolas", "Thierry", "Bernard", "Jerome"),
    age = c(27, 25, 29, 26),
    height = c(180, 170, 185, 169),
    married = c(TRUE, FALSE, TRUE, TRUE)
)

metadata<-read.csv("Ecoli_metadata.csv",stringsAsFactors = T)
metadata_tib<-read_csv("Ecoli_metadata.csv")
as.data.frame(metadata_tib)
as_tibble(metadata)

metadata_tib[1,]

metadata_tib$sample

metadata_tib[,"sample"]

metadata_tib[,c("sample","clade")]


### Tidy data

messy <- data.frame(
    name = c("Wilbur", "Petunia", "Gregory"),
    gender=c("Male","Female","Male"),
    drugA = c(67, 80, 64),
    drugB = c(56, 90, 50)
)

head(messy)
gather(messy,key = "drug",value = "heartrate")
gather(messy,key = "drug",value = "heartrate",drugA:drugB)
gather(messy,key = "drug",value = "heartrate",-name,-gender)


x[2:5]
x[-1]

set.seed(10)
messy <- data.frame(
    id = 1:4,
    trt = sample(rep(c('control', 'treatment'), each = 2)),
    work.T1 = runif(4),
    home.T1 = runif(4),
    work.T2 = runif(4),
    home.T2 = runif(4)
)

gather(messy,key = "Place",value="x",-id,-trt)
long<-gather(messy,key = "Place",value="x",work.T1:home.T2)

separate(long,col = Place,into = c("Place","Timepoint"),sep = "\\.")

## dplyr
select(messy,-id)

filter(messy,trt=="control")

selected<-select(metadata, sample, clade, cit, genome_size)

filter(selected,cit %in% c("plus","minus") )
filter(metadata,generation <= 30000)


new<-metadata %>% filter(cit=="plus") %>% select(cit,run)

metadata %>% filter(clade=="Cit+") %>% select(sample, cit, genome_size)

metadata %>% mutate(genome_bp=genome_size*1e6)

metadata %>% mutate(generation=generation/max(generation))

metadata %>% group_by(cit,generation) %>% summarise(average=mean(genome_size))

metadata %>% group_by(cit,generation)

ggplot(data = metadat)

metadata %>% filter(generation > 2000) %>% ggplot(mapping = aes(x=sample,y = genome_size))


variants<-read_csv("combined_tidy_vcf.csv")

first_plot<-variants %>% ggplot(aes(x = POS,y=DP,color=sample_id))
first_plot + geom_point(alpha=0.5)

ggplot(variants,aes(x=sample_id,y=DP,fill=sample_id)) +geom_boxplot()

Brauer<-read_csv("Brauer2008_DataSet1.csv")

tidy_data<-separate(Brauer, 
         col="NAME",
         into = c("Name","function","function2","SystematicName","acc"),
         sep="\\|\\|") %>%
    select(-GID,-GWEIGHT,-YORF) %>% gather(key = "Nutrients_Conc",value="Expression",G0.05:U0.3)

tidy_data %>% separate(col=Nutrients_Conc,into = c("Nutrient","Conc"),sep = 1)

## dplyr
tidy_data %>% mutate(Name=trimws(Name,which = "right"))

## Old way 
tidy_data$Name<-trimws(tidy_data$Name,which = "right")

Brauer<-read_csv("Brauer2008_DataSet1.csv") %>%separate(col="NAME",
                                                        into = c("Name","function","function2","SystematicName","acc"),
                                                        sep="\\|\\|")




