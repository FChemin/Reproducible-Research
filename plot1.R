## Make a plot that answers the question: what is the relationship 
## between mean covered charges (Average.Covered.Charges) 
## and mean total payments (Average.Total.Payments) in New York?

url <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1474502400&Signature=TKwh1KviAAZ~8D6U96czcGr2qE63HkBeVmBW0s0sREEJ8nwwk~rl-W8ZFAHS423~eMV~q1eAII1f124wg-0Rpryevaz4NPBMpOXmGI~VfX5V1XypVDahXluA0grA217CMqVHG6ENzk0QWGYUPu7DwQVq3zuVotk0OFW6w-hXL0c_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"

download.file(url, destfile = "payment.csv", method = "curl")

data <- read.csv(file = "payment.csv", header = TRUE, sep = ",")

subNY <- grepl("NY", data$Hospital.Referral.Region.Description, ignore.case = TRUE)
dataNY <- data[subNY,]

pdf("plot1.pdf")
plot(dataNY$Average.Covered.Charges, dataNY$Average.Total.Payments, xlab = "Average Covered Charges (in $)", 
     ylab = "Average Total Payments (in $)",
     main = "Relationship between Charges and Payments in New York", col = adjustcolor("blue", alpha = 0.5), pch = 16)
abline(lm(dataNY$Average.Total.Payments ~ dataNY$Average.Covered.Charges), col = "red", lwd = 1.5)
dev.off()