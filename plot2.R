require(tidyverse)

# 1. Read data

# The data needs to be present in the script directory in the folder "exdata_data_household_power_consumption"
raw_data <- read.csv2(file = file.path("exdata_data_household_power_consumption","household_power_consumption.txt"), dec = ".", stringsAsFactors = F)


# 2. prepare and filter data 
# Missing data points are removed in this step.

data <- raw_data %>% 
    mutate(Datetime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))) %>%
    mutate(Date = as.Date(Date,format = "%d/%m/%Y")) %>% 
    filter(Date == "2007-02-01" | Date == "2007-02-02") %>% 
    filter(Global_active_power != "?") %>% 
    mutate(Global_active_power = as.numeric(Global_active_power))


# 3. create plot

png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$Datetime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
