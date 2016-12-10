# eventually functions will go into dedicated package at http://github.com/bbest/infogrpahiq

create_pages = function(){
  # create_pages()
  
  library(tidyverse)
  
  # filter indicators to element from parameter
  d = read_csv('svg/indicators.csv') %>%
    filter(!is.na(csv_url))
  
  for (element in unique(d$element)){ # element = unique(d$element)[1]
    rmd = sprintf('pages/%s.Rmd', element) 
    write_lines('---
output:
  html_document:
    self_contained: false
    lib_dir: "libs"
params:
  element: "pinnipeds"
---

```{r, echo=FALSE, message=FALSE, warning=FALSE}
knitr::opts_chunk$set(echo=F, message=F)
source("../functions.R")
```
', rmd)
    
    d_e = filter(d, element == element)

    for (i in 1:nrow(d_e)){

      write_lines(sprintf('
```{r}
plot_timeseries(
  csv_tv  = "%s",
  title   = "%s",
  y_label = "%s")
```
', d_e$csv_url[i], d_e$indicator[i], d_e$y_label[i]), rmd, append=T)
    }
    rmarkdown::render(rmd)
  }
}

plot_timeseries = function(
  csv_tv, 
  title,
  y_label,
  x_label='Year',
  v_label=y_label,
  skip=2){

  # debug  
  # csv_tv = 'http://oceanview.pfeg.noaa.gov/erddap/tabledap/cciea_MM_pup_count.csv?time,mean_growth_rate'
  # title  = 'Female sea lion pup growth rate'
  # y_label = 'Mean growth rate'
  # x_label = 'Year'
  # v_label = y_label
  # skip = 2
  #
  # plot_timeseries(
  #   csv_tv  = 'http://oceanview.pfeg.noaa.gov/erddap/tabledap/cciea_MM_pup_count.csv?time,mean_growth_rate',
  #   title   = 'Female sea lion pup growth rate',
  #   y_label = 'Mean growth rate')

  library(tidyverse)
  library(dygraphs) # devtools::install_github("rstudio/dygraphs")
  library(xts)
  library(lubridate)

  d = read_csv(csv_tv, skip=skip, col_names=c('t','v')) %>%
    filter(!is.nan(v))
  
  m = d %>%
    summarize(
      mean    = mean(v),
      sd      = sd(v),
      se      = sd(v)/sqrt(length(v)),
      se_hi   = mean(v)+se,
      se_lo   = mean(v)-se,
      sd_hi   = mean(v)+sd,
      sd_lo   = mean(v)-sd,
      ci95_hi = mean(v)+2*se,
      ci95_lo = mean(v)-2*se)
  
  w = d %>%
    select(-t) %>%
    as.xts(., order.by=d$t) %>%
    dygraph(
      main=title) %>%
      #width=488, height=480) %>%
    dySeries('v', color='red', strokeWidth=2, label=v_label) %>%
    dyAxis('x', label=x_label, valueRange=c(as.Date(min(d$t)), today())) %>%
    dyAxis('y', label=y_label) %>%
    dyShading(from=max(d$t) - years(5), to=max(d$t), color='#CCEBD6') %>%
    dyLimit(m$sd_hi, color='green', label='+1sd', strokePattern='solid') %>%
    dyLimit(m$mean,  color='green', label='mean', strokePattern='dashed') %>%
    dyLimit(m$sd_lo, color='green', label='-1sd', strokePattern='solid')
    #dyRangeSelector()
  
  #htmlwidgets::saveWidget(w, file = "w.html", selfcontained = FALSE)
  
  return(w)
}