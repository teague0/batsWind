#Bat literature summary -- Clarivate search. Publications were manually classified as relevant (there was a lot of bird / BAT algorithm & installation papers), as review, research, or intervention-based work, the country(ies) where it took place.

#remotes::install_github("ropensci/rnaturalearthhires")
library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)
library(plotly)
library(sf)
library(here)
library(matlab)

pubs <- read.csv("./data/pubsBatWindTurbine.csv")

pubs %>% group_by(Type..research..intervention..review.) %>% 
  summarize(count = n())

pubsok <- pubs %>% filter(Type..research..intervention..review. %in% c("research", "intervention", "review"))

pubsok %>% group_by(Type..research..intervention..review.) %>% 
  summarize(count = n())

countrySums <- pubsok %>% group_by(Country) %>% 
  summarize(total = n())

countryIntv <- pubsok %>% filter(Type..research..intervention..review. == "intervention") %>% 
  group_by(Country) %>% 
  summarize(total = n())

#Map the counts for total work & then just for interventions

world <- ne_countries(scale = "large", returnclass = "sf")
worldWindTotal <- world %>% left_join(countrySums, by = c("name" = "Country"))
worldWindInter <- world %>% left_join(countryIntv, by = c("name" = "Country"))

p <- ggplot()+
  geom_sf(data = worldWindTotal, fill = "white")+
  geom_sf(data = worldWindTotal, aes(fill = total))+
  geom_sf(data = worldWindTotal %>% filter(is.na(total)), fill = "white")+
  scale_fill_viridis_c(option = "turbo",
                       trans = "sqrt",
                       name = "Number of\nStudies")+
  theme_bw()+
  theme(legend.position = "bottom")
p
ggsave(filename = "./output/GlobalWindTotal_sqrtX.png")

p2 <- ggplot()+
  geom_sf(data = worldWindInter, fill = "white")+
  geom_sf(data = worldWindInter, aes(fill = total))+
  geom_sf(data = worldWindInter %>% filter(is.na(total)), fill = "white")+
  scale_fill_viridis_c(option = "turbo",
                       trans = "sqrt",
                       name = "Number of\nStudies")+
  theme_bw()+
  theme(legend.position = "bottom")
p2
ggsave(filename = "./output/GlobalWindIntv_sqrtX.png")
