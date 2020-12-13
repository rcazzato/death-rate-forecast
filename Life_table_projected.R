#rifare il modello di lee carter per costruire la tavola

Switzerland.LC1 <- lca(Switzerland, series=names(Switzerland$rate)[3], years=1960:2016)
plot(forecast(Switzerland.LC1, h = 34)$kt)
#plot(forecast(Switzerland.LC1$kt))

#Plotting Lee-Carter death rates per comparare 

plot(Switzerland, series=names(Switzerland$rate)[3], years=1960:2016) #past values

plot(fitted(Switzerland.LC1), main = "Switzerland:total LC death rates (1960-2016)") #Fitted Values

plot(forecast(Switzerland.LC1))

# costruisco la tavola di mortalità

Switzerland_2017_2050.lt <- lifetable(forecast(Switzerland.LC1, h = 34))
plot(Switzerland_2017_2050.lt)
Switzerland_2050.lt <- lifetable(forecast(Switzerland.LC1, h = 34), years = 2050, ages = 50:100)
tav2050 <- print(Switzerland_2050.lt)
write.table(tav2050, "/Users/ruggerocazzato/Desktop/tav2050.txt") #creare file sul desktop 
