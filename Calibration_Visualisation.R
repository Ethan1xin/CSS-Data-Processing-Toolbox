folder_name_obs <- "T:/~Projects/J000492 - Toorale Water Balance Modelling/Data/20211118_WaterNSW_Data/"



time_step <- 30 # (mins)
zero_gauging <- c("423007" = 95.442, "423008" = 102.595) # character indexing
check_gauges <- c("423007" = "DicksDam_H", "423008" = "Boera_H")

sim_input <- c(Region = "Toorale", Model = "SGS", Event = "EXG", Grid = "25m", 
               Event = "March2020", Scenario = "matSens03c", "2d", Variable = "H")
sim_file <- get_input_files() # "Toorale_SGS_EXG_25m_March2020_matSens03c_2d_H.csv"

organise_sim_data <- function(sim_file = sim_file, check_gauges = check_gauges){
        sim_data <- read.table(sim_file, sep = ",", encoding = "UTF-8", check.names = F , header = T) # Identify colnames contain blanks
        check_points = colnames(sim_data)
        check_points_splitted <- strsplit(check_points, split = " ")
        stage_data_sim <- as.data.frame(array(NA, dim=c(nrow(sim_data), 2)))
        # Simulated data
        for(i in seq(check_gauges)){
                index = grep(as.character(check_gauges[i]), check_points_splitted)
                col_num <- index + 1
                if(i == 1){
                        stage_data_sim <- sim_data[,c(2,col_num)]
                        colnames(stage_data_sim) <- c("Time (h)", names(check_gauges[i]))
                }else{
                        stage_data_sim$temp <- sim_data[,col_num]
                        colnames(stage_data_sim)[which(colnames(stage_data_sim) == "temp")] <- names(check_gauges[i])
                }
        }
        returm(stage_data_sim)
}







