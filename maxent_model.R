# Load libraries
library(dismo)

set.seed(42)

# Separar dados em Treino/Teste
idx_treino <- sample(nrow(thraupis_sayaca_locations), 
                     nrow(thraupis_sayaca_locations) * 0.8)

treino <- thraupis_sayaca_locations[idx_treino, ]
teste  <- thraupis_sayaca_locations[-idx_treino, ]

# Treina o modelo
maxent_model_eval <- maxent(env_data_current, treino)
maxent_model_eval

# Avaliar 
bg <- randomPoints(env_data_current, 10000)
eval <- evaluate(teste, bg, maxent_model_eval, env_data_current)
eval
plot(eval, "ROC")

# Forecasting Atual
predictions <- predict(env_data_current,
                       maxent_model_eval)

ext_brasil <- extent(-75, -28, -35, 6)

plot(predictions, ext=ext_brasil, main="Adequabilidade Atual - T. sayaca")
points(thraupis_sayaca_locations, pch="+", cex=0.5)

tr <- threshold(eval, stat='prevalence')

plot(predictions > tr, ext=ext_brasil, main="Presença/Ausência Atual")
points(thraupis_sayaca_locations, pch="+", cex=0.5)

# Forecasting futuro
predictions_forecast <- predict(maxent_model, env_data_forecast)

plot(predictions_forecast, ext=ext_brasil,
     main="Adequabilidade Futura - T. sayaca")

plot(predictions_forecast > tr, ext=ext_brasil, main="Presença/Ausência Futura")

plot(predictions_forecast - predictions,
     ext=ext_brasil,
     main="Mudança de Adequabilidade")

