#
# global.R - the purpose of this R script is to manage reading of data files

library(shiny)
library(leaflet)
library(dplyr)
library(plotly)
library(leaflet)
library(shinyWidgets)

temp <- tempfile()
download.file("https://ga-covid19.ondemand.sas.com/docs/ga_covid_data.zip", temp, mode="wb")
unzip(temp,"county_cases.csv")
GACovidData <- read.table("county_cases.csv", sep=",", header=TRUE)
unlink(temp)

County_Name <- c("Appling","Atkinson","Bacon","Baker","Baldwin","Banks","Barrow",
                 "Bartow","Ben Hill","Berrien","Bibb","Bleckley","Brantley","Brooks",
                 "Bryan","Bulloch","Burke","Butts","Calhoun","Camden","Candler",
                 "Carroll","Catoosa","Charlton","Chatham","Chattahoochee","Chattooga","Cherokee",
                 "Clarke","Clay","Clayton","Clinch","Cobb","Coffee","Colquitt",
                 "Columbia","Cook","Coweta","Crawford","Crisp","Dade","Dawson",
                 "Decatur","DeKalb","Dodge","Dooly","Dougherty","Douglas","Early",
                 "Echols","Effingham","Elbert","Emanuel","Evans","Fannin","Fayette",
                 "Floyd","Forsyth","Franklin","Fulton","Gilmer","Glascock","Glynn",
                 "Gordon","Grady","Greene","Gwinnett","Habersham","Hall","Hancock",
                 "Haralson","Harris","Hart","Heard","Henry","Houston","Irwin",
                 "Jackson","Jasper","Jeff Davis","Jefferson","Jenkins","Johnson","Jones",
                 "Lamar","Lanier","Laurens","Lee","Liberty","Lincoln","Long",
                 "Lowndes","Lumpkin","Macon","Madison","Marion","McDuffie","McIntosh",
                 "Meriwether","Miller","Mitchell","Monroe","Montgomery","Morgan","Murray",
                 "Muscogee","Newton","Oconee","Oglethorpe","Paulding","Peach","Pickens",
                 "Pierce","Pike","Polk","Pulaski","Putnam","Quitman","Rabun",
                 "Randolph","Richmond","Rockdale","Schley","Screven","Seminole","Spalding",
                 "Stephens","Stewart","Sumter","Talbot","Taliaferro","Tattnall","Taylor",
                 "Telfair","Terrell","Thomas","Tift","Toombs","Towns","Treutlen",
                 "Treutlen","Troup","Turner","Twiggs","Union","Upson","Walker",
                 "Walton","Ware","Warren","Washington","Wayne","Webster","Wheeler",
                 "White","Whitfield","Wilcox","Wilkes","Wilkinson","Worth")
                 
County_Seat <- c("Baxley","Pearson","Alma","Newton","Milledgeville","Homer","Winder",
                 "Cartersville","Fitzgerald","Nashville","Macon","Cochran","Nahunta","Quitman",
                 "Pembroke","Statesboro","Waynesboro","Jackson","Morgan","Woodbine","Metter",
                 "Carrollton","Ringgold","Folkston","Savannah","Cusseta","Summerville","Canton",
                 "Athens","Fort Gaines","Jonesboro","Homerville","Marietta","Douglas","Moultrie",
                 "Evans","Adel","Newnan","Knoxville","Cordele","Trenton","Dawsonville",
                 "Bainbridge","Decatur","Eastman","Vienna","Albany","Douglasville","Blakely",
                 "Statenville","Springfield","Elberton","Swainsboro","Claxton","Blue Ridge","Fayetteville",
                 "Rome","Cumming","Carnesville","Atlanta","Ellijay","Gibson","Brunswick",
                 "Calhoun","Cairo","Greensboro","Lawrenceville","Clarkesville","Gainesville","Sparta",
                 "Buchanan","Hamilton","Hartwell","Franklin","McDonough","Perry","Ocilla",
                 "Jefferson","Monticello","Hazlehurst","Louisville","Millen","Wrightsville","Gray",
                 "Barnesville","Lakeland","Dublin","Leesburg","Hinesville","Lincolnton","Ludowici",
                 "Valdosta","Dahlonega","Oglethorpe","Danielsville","Buena Vista","Thomson","Darien",
                 "Greenville","Colquitt","Camilla","Forsyth","Mount Vernon","Madison","Chatsworth",
                 "Columbus","Covington","Watkinsville","Lexington","Dallas","Fort Valley","Jasper",
                 "Blackshear","Zebulon","Cedartown","Hawkinsville","Eatonton","Georgetown","Clayton",
                 "Cuthbert","Augusta","Conyers","Ellaville","Sylvania","Donalsonville","Griffin",
                 "Toccoa","Lumpkin","Americus","Talbotton","Crawfordville","Reidsville","Butler",
                 "McRae","Dawson","Thomasville","Tifton","Lyons","Hiawassee","Soperton",
                 "Soperton","LaGrange","Ashburn","Jeffersonville","Blairsville","Thomaston","LaFayette",
                 "Monroe","Waycross","Warrenton","Sandersville","Jesup","Preston","Alamo",
                 "Cleveland","Dalton","Abbeville","Washington","Irwinton","Sylvester")

LATITUDE <- c("31.70408","31.298333","31.541667","31.316667","33.087778","34.333889","33.303333",
              "34.165929","31.715556","31.206944","32.834722","32.386667","31.204444","30.784722",
              "32.135908","32.445278","33.090556","33.293611","31.538889","30.963758","32.396389",
              "33.580833","34.917222","30.834444","32.016667","32.305556","32.305556","34.227222",
              "33.951986","31.614167","33.524444","31.036944","33.953333","31.5075","31.166667",
              "33.5375","31.138333","33.376389","31.648333","31.964167","34.875556","34.421205",
              "30.904722","33.771389","32.197778","32.091408","31.582222","33.749722","31.376667",
              "30.703454","32.368333","34.109722","32.593611","32.160833","34.868333","33.447778",
              "34.257101","34.20709","34.371389","33.755","34.694722","33.232778","31.158889",
              "34.502561","30.883333","33.571667","33.953056","34.612961","34.304444","33.283333",
              "33.801667","32.764722","34.352778","33.279722","33.447181","32.458219","31.594219",
              "34.126667","33.303333","31.866111","33.004167","32.803847","32.729478","33.0086",
              "33.053056","31.039167","32.5375","31.732778","31.8325","33.794444","31.710556",
              "30.846667","34.533333","32.293852","34.124167","32.318333","33.467222","31.371111",
              "33.027778","31.173056","31.230278","33.034563","32.181389","33.59564","34.766764",
              "32.492222","33.596533","33.862778","33.870278","33.918611","32.553396","34.469167",
              "31.298889","33.098889","34.015278","32.283611","33.326389","31.884737","34.877778",
              "31.770833","33.466667","33.667579","32.23074","32.7507","31.040833","33.2475",
              "34.577213","32.049722","32.075278","32.678056","33.554722","32.083889","32.557153",
              "32.064444","31.773889","30.836389","31.450405","32.204167","34.948955","32.376111",
              "32.376111","33.036667","31.704444","32.683889","34.875556","32.887579","34.709722",
              "33.793333","31.213408","33.4075","32.981944","31.607136","31.213408","32.148333",
              "34.596389","34.771111","31.991667","33.735278","32.811944","31.531389")
LONGITUDE <- c("-82.320398","-82.852778","-82.466667","-84.339444","-83.233333","-83.499722","-83.685833",
               "-84.797749","-83.256389","-83.246667","-83.651667","-83.350556","-81.982222","-83.560833",
               "-81.621857","-81.779167","-82.015278","-83.966709","-84.601111","-81.72283","-82.0625",
               "-85.076667","-85.115833","-82.004722","-81.116667","-84.776944","-84.776944","-84.494722",
               "-83.383333","-85.048333","-84.354167","-82.751389","-84.540556","-82.850833","-83.783333",
               "-82.127778","-83.425833","-84.788611","-83.382778","-83.777222","-85.508611","-84.11908",
               "-84.571111","-84.297778","-83.179167","-83.796366","-84.165556","-84.723056","-84.933889",
               "-83.028043","-81.310278","-82.865556","-82.332222","-81.908611","-84.321111","-84.461667",
               "-85.16466","-84.140098","-83.233611","-84.39","-84.48361","-82.595278","-81.489167",
               "-84.216667","-84.951046","-83.180833","-83.9925","-83.524226","-83.833889","-82.966667",
               "-85.183611","-84.873056","-82.931111","-85.098333","-84.146925","-83.731621","-83.250554",
               "-83.590278","-83.685833","-82.599444","-82.404722","-81.949109","-82.719613","-83.5342",
               "-84.156111","-83.070278","-82.918333","-84.170833","-81.611667","-83.794444","-81.744444",
               "-83.283056","-83.983333","-84.061011","-83.216389","-84.516111","-83.467222","-81.430833",
               "-84.713611","-84.728611","-84.209167","-83.938951","-82.593889","-83.468006","-84.770066",
               "-84.940278","-83.859925","-83.408056","-83.110833","-84.840833","-83.888105","-84.434167",
               "-82.247778","-84.342222","-85.253889","-83.476667","-83.387778","-85.108863","-83.401667",
               "-84.793611","-81.966667","-84.017642","-84.308673","-81.6369","-84.878333","-84.270833",
               "-83.333047","-84.795833","-84.226667","-84.539722","-82.898333","-82.120833","-84.237323",
               "-82.898333","-84.440833","-83.978333","-83.508839","-82.322778","-83.757534","-82.592778",
               "-82.592778","-85.031944","-83.653889","-83.339722","-83.956667","-84.326736","-85.283889",
               "-83.710833","-82.354049","-82.662778","-82.809722","-81.885324","-84.538333","-82.778611",
               "-83.763889","-84.971667","-83.3075","-82.741389","-83.176667","-83.836111")

countyGEO <- as.data.frame(cbind(County_Name, County_Seat,LATITUDE,LONGITUDE))

countyGEO$LATITUDE <- as.numeric(countyGEO$LATITUDE)
countyGEO$LONGITUDE <- as.numeric(countyGEO$LONGITUDE)

colnames(GACovidData)[1] <- "County_Name"
GACovidData$County_Seat <- countyGEO[match(x=GACovidData$County_Name, countyGEO$County_Name),2]
GACovidData$LATITUDE <- countyGEO[match(x=GACovidData$County_Name, countyGEO$County_Name),3]
GACovidData$LONGITUDE <- countyGEO[match(x=GACovidData$County_Name, countyGEO$County_Name),4]

GACovidData$LATITUDE <- as.numeric(GACovidData$LATITUDE)
GACovidData$LONGITUDE <- as.numeric(GACovidData$LONGITUDE)
GACovidData <- GACovidData %>% rename(Population=population, Cases=cases, 
                                      Case_Rate=case.rate, Deaths=deaths, 
                                      Death_Rate=death.rate, 
                                      Hospitalizations=hospitalization)


str(GACovidData)

df <- GACovidData
