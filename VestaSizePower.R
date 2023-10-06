library(tidyverse)
library(lubridate)


d1 <- read_csv("./data/Vestas SizeV126.txt", col_names = FALSE)
d1$turbine <- "Vestas V126"
d2 <- read_csv("./data/Vestas SizeV164.txt", col_names = FALSE)
d2$turbine <- "Vestas V164"
d3 <- read_csv("./data/Vestas SizeV66.txt", col_names = FALSE)
d3$turbine <- "Vestas V66"
d4 <- read_csv("./data/Vestas SizV90e.txt", col_names = FALSE)
d4$turbine <- "Vestas V90"

dat <- rbind(d2, d1, d4, d3)
names(dat) <- c("power", "windSpeed", "turbine")
dat$turbine <- factor(dat$turbine, levels = c("Vestas V66", "Vestas V90", "Vestas V126", "Vestas V164"))

ggplot(dat)+
  geom_line(aes(x = windSpeed, y = power, color = turbine), linewidth = 2)+
  scale_color_brewer(palette = "Paired",
                     name = "Turbine Model")+
  theme_bw()+
  theme(legend.position = c(0.15, 0.8), 
        legend.background = element_blank())+
  labs(x = "Wind Speed (m/s)",
       y = "Power (kW)")
ggsave("./output/VestasComparison.png")  


ggplot(dat)+
  annotate("rect", xmin = 0, xmax = 5, ymin = 0, ymax = Inf, alpha = 0.2)+
  geom_line(aes(x = windSpeed, y = power, color = turbine), linewidth = 2)+
  scale_color_brewer(palette = "Paired",
                     name = "Turbine Model")+
  theme_bw()+
  theme(legend.position = c(0.15, 0.8), 
        legend.background = element_blank())+
  labs(x = "Wind Speed (m/s)",
       y = "Power (kW)")
ggsave("./output/VestasComparisonCurt.png")  