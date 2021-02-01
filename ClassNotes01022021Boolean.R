## Boolean Logic Practice

x = TRUE
y = FALSE

vec = c (0,1,2,3)
vec[c(FALSE,TRUE,TRUE,FALSE)] #this will not return the 1st and 4th elements (no one would actually do it like this)

x = 5
y = 10

x < y
x > y
x == y
x != y

animal = "fish"
zoo = c("fish", "lions", "elephants")
animal %in% zoo

animal = "dog"
animal %in% zoo

x = 4
y = c(2,4,5,8)

x < y

world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans$avg_depth_m > 4000 # test condition