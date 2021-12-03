organise_sim_data <- function(sim_file, check_gauges){
        sim_data <- read.table(sim_file, sep = ",", encoding = "UTF-8", check.names = F , header = T) # Identify colnames contain blanks
        check_points = colnames(sim_data)
        check_points_splitted <- strsplit(check_points, split = " ")
        stage_data_sim <- as.data.frame(array(NA, dim=c(nrow(sim_data), 2)))
        check_gauges <- c("423007" = "DicksDam_H", "423008" = "Boera_H")
        # Simulated data
        starting_time <- as.POSIXct("2020-03-04 12:45:00",tz="Australia/Sydney")
        for(i in seq(check_gauges)){
                index = grep(as.character(check_gauges[i]), check_points_splitted)
                col_num <- index
                if(i == 1){
                        stage_data_sim <- sim_data[,c(2,col_num)]
                        colnames(stage_data_sim) <- c("Time (h)", names(check_gauges[i]))
                }else{
                        stage_data_sim <- stage_data_sim %>% mutate(temp = sim_data[,col_num])
                        colnames(stage_data_sim)[which(colnames(stage_data_sim) == "temp")] <- names(check_gauges[i])
                }
        }
        stage_data_sim_updated <- stage_data_sim %>% mutate(Time_ts = as.POSIXct(stage_data_sim[,1]*60*60 + as.numeric(starting_time), tz = "Australia/Brisbane" , origin='1970-01-01'))
        return(stage_data_sim_updated)
}
