#Importing data and 

library(plyr)


df <- read.table("201601.csv", header=FALSE, sep=",", fill=TRUE, na.strings = c("-"))
d1 <- df[ , c(1,2,3,9,11,17,20, 21, 23, 25)]
colnames(d1) <- c("macid", "uuid", "campus", "date and time", "connection length", "total traffic", "wifi", "device type", "manufacturor", "operating system")

df2 <- read.table("201602.csv", header=FALSE, sep=",", fill=TRUE, na.strings = c("-"))
d2 <- df2[ , c(1,2,3,9,11,17,20, 21, 23, 25)]
colnames(d2) <- c("macid", "uuid", "campus", "date and time", "connection length", "total traffic", "wifi", "device type", "manufacturor", "operating system")


df3 <- read.table("201603.csv", header=FALSE, sep=",", fill=TRUE, na.strings = c("-"))
d3 <- df3[ , c(1,2,3,9,11,17,20, 21, 23, 25)]
colnames(d3) <- c("macid", "uuid", "campus", "date and time", "connection length", "total traffic", "wifi", "device type", "manufacturor", "operating system")



df4 <- read.table("201604.csv", header=FALSE, sep=",", fill=TRUE, na.strings = c("-"))
d4 <- df3[ , c(1,2,3,9,11,17,20, 21, 23, 25)]
colnames(d4) <- c("macid", "uuid", "campus", "date and time", "connection length", "total traffic", "wifi", "device type", "manufacturor", "operating system")



df5 <- read.table("201605.csv", header=FALSE, sep=",", fill=TRUE, na.strings = c("-"))
d5 <- df5[ , c(1,2,3,18, 19, 25, 28, 29,31,33)]
colnames(d5) <- c("macid", "uuid", "campus", "date and time", "connection length", "total traffic", "wifi", "device type", "manufacturor", "operating system")



df6 <- read.table("201606.csv", header=FALSE, sep=",", fill=TRUE, na.strings = c("-"))
d6 <- df6[ , c(1,2,3,18, 19, 25, 28, 29,31,33)]
colnames(d6) <- c("macid", "uuid", "campus", "date and time", "connection length", "total traffic", "wifi", "device type", "manufacturor", "operating system")

#Combining dataframes

d <- rbind(d1,d2,d3,d4,d5, d6)

#Used the replace fuNction to clean up the campus data

d$campus <- as.character(d$campus)

d$campus[d$campus == "cuc"] <- "CUC"
d$campus[d$campus == "cuc.claremont.edu"] <- "CUC"

d$campus[d$campus == "cgu"] <- "CGU"
d$campus[d$campus == "cgu.edu"] <- "CGU"

d$campus[d$campus == "kgi"] <- "KGI"
d$campus[d$campus == "kgi.edu"] <- "KGI"

d$campus[d$campus == "hmc"] <- "HMC"
d$campus[d$campus == "hmc.edu"] <- "HMC"

d$campus[d$campus == "pom"] <- "POM"


d$campus[d$campus == "pit"] <- "PZ"
d$campus[d$campus == "PIT"] <- "PZ"
d$campus[d$campus == "pitzer.edu"] <- "PZ"




d$campus[d$campus == "scr"] <- "SCR"
d$campus[d$campus == "scrippscollege.edu"] <- "SCR"

d$campus[d$campus == "cmc"] <- "CMC"
d$campus[d$campus == "cmc.edu"] <- "CMC"




# Creating campus subsets

d_cgu <- subset(d, campus== "CGU")
d_kgi <- subset(d, campus== "KGI")
d_cuc <- subset(d, campus== "CUC")
d_pom <- subset(d, campus== "POM")
d_hmc <- subset(d, campus== "HMC")
d_scr <- subset(d, campus== "SCR")
d_pz <- subset(d, campus=="PZ")
d_cmc <- subset(d, campus == "CMC")

##changing column names so count can work. Removing the space in the name

colnames(d)[4] <- "date_time"
colnames(d)[5] <- "connection_length"
colnames(d)[6] <- "traffic"
colnames(d)[8] <- "device"
colnames(d)[10] <- "os"

colnames(d_cgu)[4] <- "date_time"
colnames(d_cgu)[5] <- "connection_length"
colnames(d_cgu)[6] <- "traffic"
colnames(d_cgu)[8] <- "device"
colnames(d_cgu)[10] <- "os"

colnames(d_kgi)[4] <- "date_time"
colnames(d_kgi)[5] <- "connection_length"
colnames(d_kgi)[6] <- "traffic"
colnames(d_kgi)[8] <- "device"
colnames(d_kgi)[10] <- "os"

colnames(d_cuc)[4] <- "date_time"
colnames(d_cuc)[5] <- "connection_length"
colnames(d_cuc)[6] <- "traffic"
colnames(d_cuc)[8] <- "device"
colnames(d)[10] <- "os"

colnames(d_hmc)[4] <- "date_time"
colnames(d_hmc)[5] <- "connection_length"
colnames(d_hmc)[6] <- "traffic"
colnames(d_hmc)[8] <- "device"
colnames(d_hmc)[10] <- "os"

colnames(d_pom)[4] <- "date_time"
colnames(d_pom)[5] <- "connection_length"
colnames(d_pom)[6] <- "traffic"
colnames(d_pom)[8] <- "device"
colnames(d_pom)[10] <- "os"

colnames(d_scr)[4] <- "date_time"
colnames(d_scr)[5] <- "connection_length"
colnames(d_scr)[6] <- "traffic"
colnames(d_scr)[8] <- "device"
colnames(d_scr)[10] <- "os"

colnames(d_pz)[4] <- "date_time"
colnames(d_pz)[5] <- "connection_length"
colnames(d_pz)[6] <- "traffic"
colnames(d_pz)[8] <- "device"
colnames(d_pz)[10] <- "os"

colnames(d_cmc)[4] <- "date_time"
colnames(d_cmc)[5] <- "connection_length"
colnames(d_cmc)[6] <- "traffic"
colnames(d_cmc)[8] <- "device"
colnames(d_cmc)[10] <- "os"

#Combining the individual school data

dx <- rbind(d_cgu, d_kgi, d_pom, d_hmc, d_scr, d_pz, d_cmc)

#For some fucked up reason, cuc refuses to bind with the rest of this data. 

##Using count for exploratory data analysis
