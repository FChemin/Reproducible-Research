## Make a plot (possibly multi-panel) that answers the question: 
## how does the relationship between mean covered charges (Average.Covered.Charges) 
## and mean total payments (Average.Total.Payments) vary by medical condition (DRG.Definition) 
## and the state in which care was received (Provider.State)?

url <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1474502400&Signature=TKwh1KviAAZ~8D6U96czcGr2qE63HkBeVmBW0s0sREEJ8nwwk~rl-W8ZFAHS423~eMV~q1eAII1f124wg-0Rpryevaz4NPBMpOXmGI~VfX5V1XypVDahXluA0grA217CMqVHG6ENzk0QWGYUPu7DwQVq3zuVotk0OFW6w-hXL0c_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"

download.file(url, destfile = "payment.csv", method = "curl")

data <- read.csv(file = "payment.csv", header = TRUE, sep = ",")
levels(data$DRG.Definition) <- c("194", "292", "392", "641", "690", "871")
states <- unique(data$Provider.State)
conditions <- unique(data$DRG.Definition)

pdf("plot2.pdf")

par(mfrow = c(6,6), oma = c(4,4,4,2), mar = rep(2,4))

for (i in states) {
  for (j in conditions){
    with(subset(data, Provider.State == i & DRG.Definition == j),
         plot(Average.Covered.Charges, Average.Total.Payments, 
         main = paste(i,j),
         ylim = range(data$Average.Total.Payments),
         xlim = range(data$Average.Covered.Charges),
         col = adjustcolor("blue", alpha = 0.5), pch = 16)
    )
    abline(lm(Average.Total.Payments~Average.Covered.Charges,
           subset(data, Provider.State == i & DRG.Definition == j)), 
           col = "red")
  }
}

mtext("Covered Charges", side = 1, outer = TRUE, line = 1)
mtext("Total Payments", side = 2, outer = TRUE, line = 1)
mtext("Relationship between Covered Charges and Total Payments
      by Medical Condition and State", side = 3, outer = TRUE, font = 2,
      line = 1)

dev.off()