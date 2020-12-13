install.packages('demography', dependencies = TRUE)
library (demography)
install.packages("devtools")
library(devtools) 
install_github("robjhyndman/demography")



Switzerland <- read.demogdata("/Users/ruggerocazzato/Desktop/Mx_1x1.txt", "/Users/ruggerocazzato/Desktop/Exposures_1x1.txt", 
                              type="mortality", label="Swiss", skip=2)

Switzerland
pop <- print(Switzerland$pop)
plot(pop)
ls(Switzerland)

plot(Switzerland, series=names(Switzerland$rate)[1], year=1900:2016, main="Switzerland-Female, 1900-2016")
plot(Switzerland, series=names(Switzerland$rate)[2], year=1900:2016, main="Switzerland-Male, 1900-2016")
plot(Switzerland, series=names(Switzerland$rate)[3], year=1900:2016, main="Switzerland-Total, 1900-2016")



Switzerlandf.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[1], years = Switzerland$year, ages = Switzerland$age, max.age = min(100, max(Switzerland$age)), type = c("period"))
Switzerlandm.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[2], years = Switzerland$year, ages = Switzerland$age, max.age = min(100, max(Switzerland$age)), type = c("period"))
Switzerlandt.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[3], years = Switzerland$year, ages = Switzerland$age, max.age = min(100, max(Switzerland$age)), type = c("period"))

lifetable_fem <- print(Switzerlandf.lt)
lifetable_mas <- print(Switzerlandm.lt)
lifetable_tot <- print(Switzerlandt.lt)

plot(Switzerlandt.lt)     #per tracciare la speranza di vita
plot(Switzerlandm.lt)
plot(Switzerlandf.lt)

age <- Switzerlandt.lt$age
year <- Switzerlandt.lt$year

persp(age,year,Switzerlandt.lt$lx, theta = 10, zlab = "lx", main = "lx. Switzerland 1876-2016")

Switzerlandt_2016.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[3], years = 2016, ages = 50:100, max.age = min(100, max(Switzerland$age)), type = c("period"))
tav2016 <- print(Switzerlandt_2016.lt) #estrarre tavola di un preciso anno

lx_2016 <- Switzerlandt_2016.lt$lx
mx_2016 <-Switzerlandt_2016.lt$mx
plot(lx_2016, col="blue", xlab="age", ylab="lx", type="l", lty=1, main = "Survivors lx. Switzerland - 2016")

write.table(tav2016, "/Users/ruggerocazzato/Desktop/tav2016.txt") #creare file sul desktop 

#confronto sopravviventi nel secolo
Switzerlandt_1900.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[3], years = 1900, ages = Switzerland$age, max.age = min(100, max(Switzerland$age)), type = c("period"))
lx_1900 <-Switzerlandt_1900.lt$lx

Switzerlandt_1950.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[3], years = 1950, ages = Switzerland$age, max.age = min(100, max(Switzerland$age)), type = c("period"))
lx_1950 <-Switzerlandt_1950.lt$lx

Switzerlandt_2016.lt <- lifetable(Switzerland, series = names(Switzerland$rate)[3], years = 2016, ages = Switzerland$age, max.age = min(100, max(Switzerland$age)), type = c("period"))
lx_2016 <-Switzerlandt_2016.lt$lx

plot(lx_1900, col="blue", xlab="age", ylab="lx", type="l", lty=1, main = "Survivors lx. Swiss - 1900, 1950, 2016")
lines(lx_1950, col="red", lty=2)
lines(lx_2016, col="green", lty=3)
legend("topright",c("1900", "1950", "2016"),col=c("blue","red", "green"), lty=1:3)

#aspettative di vita alla nascita, metti questi 3 sulla tesina
e0_female <- life.expectancy(Switzerland, series = names(Switzerland$rate)[1],  years = 1950:2016, type = c("period"))
e0_male <- life.expectancy(Switzerland, series = names(Switzerland$rate)[2],  years = 1950:2016, type = c("period"))
e0_total <- life.expectancy(Switzerland, series = names(Switzerland$rate)[3],  years = 1950:2016, type = c("period"))

plot(e0_female, main= "Aspettativa di vita alla nascita: femminile")
plot(e0_male, main="Aspettativa di vita alla nascita: maschile")
plot(e0_total, main="Aspettativa di vita alla nascita: totale")


