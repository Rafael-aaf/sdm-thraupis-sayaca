######################################
# SDM da espécie Thraupis sayaca
#
# Autor: Rafael Ferreira, Data: 08-03-26
######################################

# Clear all variables in workspace
rm(list=ls())

# Load libraries
library(dismo)
library(dplyr)
library(ggplot2)

# Load Data
thraupis_sayaca_data <- read.csv("thraupis_sayaca_ocorrences2.csv")
env_data_current <- stack("env_current.grd")
env_data_forecast <- stack("env_forecast.grd")

env_data_current$tmin <- env_data_current$tmin / 10
env_data_forecast$tmin <- env_data_forecast$tmin / 10

# Plot initial data
plot(env_data_current$tmin, main = "Temperatura Mínima (°C)")
plot(env_data_current$precip, main = "Precipitação (mm)")

# Preparing Data
thraupis_sayaca_locations <- select(thraupis_sayaca_data,
                                    decimalLongitude, decimalLatitude)
thraupis_sayaca_env <- extract(env_data_current, thraupis_sayaca_locations)
thraupis_sayaca_data <- cbind(thraupis_sayaca_data, thraupis_sayaca_env)

ggplot(thraupis_sayaca_data,
       mapping=aes(x=tmin, y=precip)) + 
  geom_point()

# Fitting in a MaxEnt model
maxent_model <- maxent(env_data_current, thraupis_sayaca_locations)
maxent_model







