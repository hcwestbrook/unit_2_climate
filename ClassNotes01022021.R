#notes from class
#ice sheets

#read in data

ant_ice_loss = read.table('data/antarctica_mass_200204_202008.txt', skip = 31, col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))
grn_ice_loss = read.table('data/greenland_mass_200204_202008.txt', skip = 31, col.names=c("decimal_date", "mass_Gt", "sigma_Gt"))

summary(ant_ice_loss)
dim(grn_ice_loss)

#### Scatter Plots ####
#plot
#x,y
#y~x
plot(mass_Gt ~ decimal_date, data = ant_ice_loss, main = "Antarctic Ice loss", ylab = "Mass Loss (Gt)")
plot(mass_Gt ~ decimal_date, data = grn_ice_loss, main = "Greenland Ice loss", ylab = "Mass Loss (Gt)")

#now i want to see them on the same plot
plot(mass_Gt ~ decimal_date, data = ant_ice_loss, main = "Ice loss", ylab = "Mass Loss (Gt)")
points(mass_Gt ~ decimal_date, data = grn_ice_loss, ylab = "Mass Loss (Gt)", col="red")

#greenland data gets cut off so lets find out the range
range(grn_ice_loss$mass_Gt)

plot(mass_Gt ~ decimal_date, data = ant_ice_loss, main = "Ice loss", ylab = "Mass Loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), type="l")
#type = "l" changes plot type from points to lines, for the next oone I can just use the lines function
lines(mass_Gt ~ decimal_date, data = grn_ice_loss, ylab = "Mass Loss (Gt)", col="red")

#There was a gap where the grace mission paused that shows up as a straight line in the graph, which makes it seem like
#the mission was still going, so lets add an NA to create a break
head(ant_ice_loss)
data_break = data.frame(decimal_date=2018, mass_Gt=NA, sigma_Gt=NA) #2018 was when the mission stopped
data_break
ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
ant_ice_loss_with_NA


#sort data with NA
order(ant_ice_loss_with_NA$decimal_date)
ant_ice_loss_with_NA = ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_date),]

#do the same w/ greenland data
grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)
grn_ice_loss_with_NA
order(grn_ice_loss_with_NA$decimal_date)
grn_ice_loss_with_NA = grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_date),]

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, main = "Ice loss", ylab = "Mass Loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), type="l")
lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", col="red")
#now both are graphed with a gap in 2018

#Plot with uncertainty
plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, main = "Ice loss", ylab = "Mass Loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), type="l", xlab="Date")
lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", col="red")
#add 2 standard deviations
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed")
#subtract 2 standard deviations
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed")
#repeat for Greenland
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed", col="red")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed", col="red")

#now we save the data, I'm copying and pasting the above for the sake of having a step by step guide
pdf('figures/ice_mass_trends_HW.pdf', width = 7, height = 5) #opens pdf device

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_with_NA, main = "Ice loss", ylab = "Mass Loss (Gt)", ylim=range(grn_ice_loss$mass_Gt), type="l", xlab="Date")
lines(mass_Gt ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", col="red")
#add 2 standard deviations
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed")
#subtract 2 standard deviations
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed")
#repeat for Greenland
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed", col="red")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data = grn_ice_loss_with_NA, ylab = "Mass Loss (Gt)", lty="dashed", col="red")

dev.off() #turns off pdf device


#### Bar plots####
min(ant_ice_loss$mass_Gt)
min(grn_ice_loss$mass_Gt)

barplot(height=c(min(ant_ice_loss$mass_Gt), min(grn_ice_loss$mass_Gt)))
#now we have two ugly gray boxes floating in space, also we should make the ice loss positive instead of negative so it's easier to understand
#y axis also needs to extend
barplot(height=c(-1*min(ant_ice_loss$mass_Gt), -1*min(grn_ice_loss$mass_Gt)), names.arg=c("Antarctica", "Greenland"), ylim=c(0,5000))

####Exercise 1.2: ####


#Calculate the average annual ice loss for each ice sheet by dividing the 
#change in ice lost from the beginning to the end of the time series by the 
#total time that passed. Then display the ice loss rates in a bar graph. 
#Save the bar graph into the `figures/` directory in this repo.
pdf('figures/ice_loss_rate_HW.pdf')
ant_rate = (max(ant_ice_loss$mass_Gt)-min(ant_ice_loss$mass_Gt))/(max(ant_ice_loss$decimal_date)-min(ant_ice_loss$decimal_date))
grn_rate = (max(grn_ice_loss$mass_Gt)-min(grn_ice_loss$mass_Gt))/(max(grn_ice_loss$decimal_date)-min(grn_ice_loss$decimal_date))
barplot(heigh=c(ant_rate, grn_rate), names.arg=c("Antarctica", "Greenland"), ylim=c(0,300))        
dev.off()