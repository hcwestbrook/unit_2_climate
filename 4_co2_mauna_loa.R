## ----setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(fig.width=6, fig.asp = 0.618, collapse=TRUE) 


## --------------------------------------------------------------------------
# co2 = read.table("data/co2_mm_mlo.txt", col.names = c("year", "month", "decimal_date", "monthly_average", "deseasonalized", "n_days", "st_dev_days", "monthly_mean_uncertainty"))

url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'
co2 = read.table(url, col.names = c("year", "month", "decimal_date", "monthly_average", "deseasonalized", "n_days", "st_dev_days", "monthly_mean_uncertainty"))


## --------------------------------------------------------------------------
class(co2) 
head(co2)  # prints first 6 rows
summary(co2) # gives type-specific summary stats for each column


## --------------------------------------------------------------------------
range(co2$decimal_date)
max(co2$monthly_average)


## --------------------------------------------------------------------------
plot(monthly_average ~ decimal_date, type="l", data=co2) 


## --------------------------------------------------------------------------
#Note '+' keeps lines together so RMarkdown doesn't close the plot before all elements are added
plot(monthly_average ~ decimal_date, type="l", data=co2, ylab="CO2 ppm", xlab="Year", main="Keeling Curve") + 
lines(y=co2$deseasonalized, x=co2$decimal_date, col="red")


## --------------------------------------------------------------------------
pdf('figures/keelingCurve.pdf', width=7, height=5)
plot(monthly_average ~ decimal_date, type="l", data=co2, ylab="CO2 ppm", xlab="Year", main="Keeling Curve") + 
lines(y=co2$deseasonalized, x=co2$decimal_date, col="red")
dev.off()


## --------------------------------------------------------------------------
co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized #Calculate detrended co2 fluctuation
head(co2)
plot(seasonal_cycle ~ decimal_date, type="l", data=co2) 


## --------------------------------------------------------------------------
# 2 ways to get the third row of the first column:
co2[1,3]  
co2$year[3]

# 2 ways to get the whole second column (commented out bc it's a lot to print)
# co2[,2]   
# co2$month 

# 2 ways to get the first 6 rows of every column
co2[c(1:6),]   
head(co2)


## --------------------------------------------------------------------------
# Showing 2 ways to subset
summary(co2$decimal_date > 2015) # vector of TRUES and FALSES
summary(which(co2$decimal_date > 2015)) # vector of indices that meet condition (see ?which for bells and whistles)

# Either method can be used to subset the data
co2_2016to2020 = co2[co2$decimal_date > 2015,]

plot(seasonal_cycle ~ decimal_date, type="l", data=co2_2016to2020) 


## --------------------------------------------------------------------------
jan_anomalies = co2[which(co2$month==1),'seasonal_cycle'] #Grab seasonal_cycle data only from the month of January
mean(jan_anomalies) #throws error because mean() wants to operate on a vector, not a list / data.frame

class(jan_anomalies)
class(unlist(jan_anomalies))

mean(unlist(jan_anomalies)) #Find mean January anomaly


## --------------------------------------------------------------------------
head(co2)
co2_monthly_cycle = data.frame(month=c(1:12), detrended_monthly_cycle=NA) #Note how it automatically recycles NA to fill the column
head(co2_monthly_cycle)

co2_monthly_cycle$detrended_monthly_cycle[1] = mean(unlist(co2[which(co2$month==1),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[2] = mean(unlist(co2[which(co2$month==2),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[3] = mean(unlist(co2[which(co2$month==3),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[4] = mean(unlist(co2[which(co2$month==4),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[5] = mean(unlist(co2[which(co2$month==5),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[6] = mean(unlist(co2[which(co2$month==6),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[7] = mean(unlist(co2[which(co2$month==7),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[8] = mean(unlist(co2[which(co2$month==8),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[9] = mean(unlist(co2[which(co2$month==9),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[10] = mean(unlist(co2[which(co2$month==10),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[11] = mean(unlist(co2[which(co2$month==11),'seasonal_cycle']))
co2_monthly_cycle$detrended_monthly_cycle[12] = mean(unlist(co2[which(co2$month==12),'seasonal_cycle']))

# Examine and plot detrended monthly cycle
co2_monthly_cycle
plot(detrended_monthly_cycle ~ month, type="l", data=co2_monthly_cycle) 

