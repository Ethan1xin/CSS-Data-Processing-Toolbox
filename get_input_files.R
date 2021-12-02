get_input_files <- 
        function(Region = "Toorale", Sampling = "SGS", Model = "EXG", Grid = "25m", 
                 Event = "March2020", Scenario = "matSens03c", Dimension = "2d", Variable = "H"){
                folder_name_sim <- "T:/~Projects/J000492 - Toorale Water Balance Modelling/Hydraulics/TUFLOW/results/March2020/2d/plot/csv/"
                sim_input <- paste(Region, Sampling, Model, Grid, 
                                   Event, Scenario, Dimension, Variable, sep = "_")
                sim_file <- paste0(folder_name_sim, sim_input, ".csv")
                return(sim_file)
        }