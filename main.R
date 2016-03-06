library(reshape)
library(dplyr)

data.csv <- read.csv("cleanflight_data_log.csv")

data <- data.csv %>% filter(RC4 > 1500) %>% mutate(angle = acos(accelerometerZ / sqrt(accelerometerX**2 + accelerometerY**2 + accelerometerZ**2)) * pi * 2)

# accelerometer <- data %>% select(timestamp, starts_with("accelerometer"))
ggplot(data = data, aes(x=timestamp)) + geom_line(aes(y=angle)) + geom_line(aes(y=Motor1))
# ggplot(data = melt(accelerometer, id.vars = c("timestamp")), aes(x=timestamp, y=value)) + geom_line(aes(color=variable))

motor <- data %>% select(timestamp, starts_with("Motor"))
ggplot(data = melt(motor, id.vars = c("timestamp")), aes(x=timestamp, y=value)) + geom_line(aes(color=variable))

rc <- data %>% select(timestamp, starts_with("RC"))
ggplot(data = melt(rc, id.vars = c("timestamp")), aes(x=timestamp, y=value)) + geom_line(aes(color=variable))
