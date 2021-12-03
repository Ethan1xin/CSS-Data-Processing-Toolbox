
# Observation data
library(zoo)
zero_gauging <- c("423007_WarregoDicksDam" = 95.442, "423008_WarregoBoeraDam" = 102.595) # character indexing
obs_input <- c("423007_WarregoDicksDam", "423008_WarregoBoeraDam")
obs_file <- paste0(folder_name_obs, obs_input, ".csv")
obs_data <- list()
for(i in seq(obs_file)){
        ##################################################################
        if(i == 1){
                waterlevel <- read.csv(obs_file[i],skip=3,header=T)
                waterlevel <- as.data.frame(waterlevel[,1:2])
                colnames(waterlevel) <- c("Time", check_gauges[i])
                # Zero Gauging
                datum_temp <- zero_gauging[which(names(zero_gauging)==obs_input[i])]
                waterlevel[,2] <- waterlevel[,2] + datum_temp
                # Result List
                obs_data[[1]] <- waterlevel
                names(obs_data)[1] <- names(zero_gauging[1])
        }else{
                waterlevel_temp <- read.csv(obs_file[i], skip=3, header = T)
                waterlevel_temp <- as.data.frame(waterlevel_temp[,1:2])
                colnames(waterlevel_temp) <- c("Time", check_gauges[i])
                # Zero Gauging
                datum_temp <- zero_gauging[which(names(zero_gauging)==obs_input[i])]
                waterlevel_temp[,2] <- waterlevel_temp[,2] + datum_temp
                # Result List
                obs_data[[i]] <- waterlevel_temp
                names(obs_data)[i] <- names(zero_gauging[i])
        }
}
library(dplyr)
for(i in 1:2){
        obs_data[[i]] <- obs_data[[i]] %>% mutate(Time_ts = as.POSIXct(Time,format = "%H:%M:%S %d/%m/%Y",tz="Australia/Sydney"))
        obs_data[[i]] <- obs_data[[i]][,c(3,2)]
}
