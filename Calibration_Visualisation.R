folder_name_obs <- "T:/~Projects/J000492 - Toorale Water Balance Modelling/Data/20211118_WaterNSW_Data/"



time_step <- 30 # (mins)
zero_gauging <- c("423007" = 95.442, "423008" = 102.595) # character indexing
check_gauges <- c("423007" = "DicksDam_H", "423008" = "Boera_H")

# Default Sim Input
source("~/CSS-Data-Processing-Toolbox/get_input_files.R")
source("~/CSS-Data-Processing-Toolbox/organise_sim_data.R")
sim_input <- c(Region = "Toorale", Model = "SGS", Event = "EXG", Grid = "25m", 
               Event = "March2020", Scenario = "matSens03c", Dimension = "2d", Variable = "H")
sim_file <- get_input_files(Grid = "15m") # "Toorale_SGS_EXG_25m_March2020_matSens03c_2d_H.csv"

stage_data_sim_updated <- organise_sim_data(sim_file = sim_file, check_gauges = check_gauges)

head(stage_data_sim_updated)



# Combine data
## Data Visualisation

source("~/CSS-Data-Processing-Toolbox/organise_obs_data.R")
obs <- obs_data[[2]]; colnames(obs) <- c("Time", "y")
sim <- stage_data_sim_updated[,c(4,3)]; colnames(sim) <- c("Time", "y")
df <- melt(list(obs=obs, sim=sim),  id.vars = "Time")

starting_time <- as.POSIXct("2020-03-04 12:45:00",tz="Australia/Sydney")
ending_time <- starting_time+60*24*60*60 # days*hours*mins*secs

ggplot(data = df) +
        geom_line(aes(x = Time, value, color = L1)) +
        scale_color_manual(values = c("Black", "Blue")) +
        xlim(starting_time, ending_time) +
        xlab("Date") + ylab("Water Level (mAHD)") +
        ggtitle("423008_WarregoBoeraDam") +
        theme_bw()


obs <- obs_data[[1]]; colnames(obs) <- c("Time", "y")
sim <- stage_data_sim_updated[,c(4,2)]; colnames(sim) <- c("Time", "y")
df <- melt(list(obs=obs, sim=sim),  id.vars = "Time")

starting_time <- as.POSIXct("2020-03-04 12:45:00",tz="Australia/Sydney")
ending_time <- starting_time+60*24*60*60 # days*hours*mins*secs

ggplot(data = df) +
        geom_line(aes(x = Time, value, color = L1)) +
        scale_color_manual(values = c("Black", "Blue")) +
        xlim(starting_time, ending_time) +
        xlab("Date") + ylab("Water Level (mAHD)") +
        ggtitle("423007_WarregoDicksDam") +
        theme_bw()
