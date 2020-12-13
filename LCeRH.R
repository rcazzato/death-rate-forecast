#per questo tipo di analisi devo usare stmomo

install.packages("StMoMo")
library(StMoMo)


#creare i vettori
Ext <- Switzerland$pop$male[, 75:141]
Dxt <- Switzerland$rate$male[, 75:141]*Ext
ages=Switzerland$age
years=Switzerland$year[75:141]

#modello Renshaw-Haberman
RH <- rh()
RHfit_Switzerland<- fit(RH, Dxt=Dxt, Ext=Ext, ages=ages, years=years , ages.fit=50:100)
RHfit_Switzerland
plot(RHfit_Switzerland) #fitting

#residual analysis

RHres_Switzerland<- residuals(RHfit_Switzerland)
plot(RHres_Switzerland, type='scatter')
plot(RHres_Switzerland, type='colourmap')

#previsione RH 
RHfor<- forecast (RHfit_Switzerland, h=34)
plot(RHfor, only.kt=TRUE)
plot(RHfor, only.gc=TRUE)


###############################################################################

#modello Lee-Carter

LC <- lc()
LCfit_Switzerland<- fit(LC, Dxt=Dxt, Ext=Ext, ages=ages, years=years , ages.fit=50:100)
plot(LCfit_Switzerland)

#residual analysis LC

LCres_Switzerland<- residuals(LCfit_Switzerland)
plot(LCres_Switzerland, type='scatter')
plot(LCres_Switzerland, type='colourmap')

#previsione LC

LCfor<- forecast (LCfit_Switzerland, h=34)
plot(LCfor, only.kt=TRUE)



#BIC comparision

BIC <- matrix ( nrow=1, ncol=2)
rownames (BIC) <- "BIC"
colnames (BIC) <- c("LC", "RH")
BIC[ 1 , 1 ] <- BIC(LCfit_Switzerland)
BIC[ 1 , 2 ] <- BIC(RHfit_Switzerland)
BIC


AIC <- matrix ( nrow=1, ncol=2)
rownames (AIC) <- "AIC"
colnames (AIC) <- c("LC", "RH")
AIC[ 1 , 1 ] <- AIC(LCfit_Switzerland)
AIC[ 1 , 2 ] <- AIC(RHfit_Switzerland)
AIC

###############################






