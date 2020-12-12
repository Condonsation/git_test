library(dplyr)

zip_codes <- read.csv("https://raw.githubusercontent.com/stanleywtlim/gannonproject/data/Store_Zip%20locations.csv?token=AQYYCVO32ENTQZCYMWMFF5S7M3H52", header = TRUE)
zip_codes$duplicate <- duplicated(zip_codes$STORE.NUMBER) ##Checked for duplicate store numbers and found none
zip_codes$duplicate <- NULL ##Deleted boolean column checking for duplicates
zip_codes <- tbl_df(zip_codes) ##call dplyr function for easier sorting

##Read in zip table with county info and prepare for left join
zip_county <- read.csv(file.path("usazipcode-county.csv")) ##bringing in zip-pcounty table
zip_county <- tbl_df(zip_county) ##call dplyr function for easier sorting
zip_county = rename(zip_county, ZIPCODE = zip) ##rename "zip" column "ZIPCODE" as primary key

##Run left join on tables
zip_merge <- merge(x = zip_codes, y = zip_county, by = "ZIPCODE", all.x = TRUE)
sum(is.na(zip_merge)) ##Check for NA--0
table(zip_merge$State)##Store locations in AL, FL, GA, LA, MS, NC, SC, & TN

zip_merge %>% filter(State == "FL") ##Best guess at chain is Winn-Dixie



