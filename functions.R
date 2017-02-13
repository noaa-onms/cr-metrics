# eventually functions will go into dedicated package at http://github.com/bbest/infogrpahiq
library(tidyverse)
library(stringr)
library(rmarkdown)

clear_site = function(){
  # clean up output docs folder, except docs/svg/
  #setdiff(list.files('docs'), c('libs','svg')) %>% file.path('docs', .) %>%
  #  unlink(recursive=T, force=T)
  unlink('docs', recursive=T, force=T)
}

create_site = function(){
  
  clear_site()
  
  # render top level pages
  rmarkdown::render_site()
  
  # filter indicators to element from parameter
  d = read_csv('data/csv_indicators.csv') %>%
    filter(!is.na(csv_url)) # View(d)
  
  dir.create('docs/pages', showWarnings = F)
  
  for (x in unique(d$element)){ # x = unique(d$element)[2]
    rmd = sprintf('docs/pages/%s.Rmd', x) 
    write_lines(sprintf(
'---
output:
  html_document:
    self_contained: false
    lib_dir: "libs"
    fig_height: 2
    fig_width: 4
params:
  element: "%s"
---

```{r, echo=FALSE, message=FALSE, warning=FALSE}
knitr::opts_chunk$set(echo=F, message=F)
source("../../functions.R")
```
', x), rmd)
    
    d_e = filter(d, element == x)

    for (i in 1:nrow(d_e)){ # i = 1

      write_lines(with(d_e, sprintf(
'
```{r}
plot_timeseries(
  csv_tv  = "%s",
  title   = "%s",
  y_label = "%s",
  skip    = %d,
  filter  = %s,
	col_t   = %s,
  col_y   = %s)
```
', 
csv_url[i], 
indicator[i], 
y_label[i],
ifelse(is.na(skip_lines[i]), 2, skip_lines[i]), 
ifelse(is.na(filter[i]), 'NULL', sprintf('"%s"', str_replace_all(filter[i], '"', '\\\\"'))), 
ifelse(is.na(col_t[i]), 'NULL', sprintf('"%s"', col_t[i])), 
ifelse(is.na(col_y[i]), 'NULL', sprintf('"%s"', col_y[i])))), rmd, append=T)
      
    }
    rmarkdown::render(rmd)
  }
  
  # copy needed dirs to output docs
  for (dir in c('data','img','libs','svg')){
    file.copy(dir, 'docs', recursive=T)
  }
  
  # serve site
  servr::httd('docs')
}

plot_timeseries = function(
  csv_tv, 
  title,
  y_label,
  x_label = 'Year',
  v_label = y_label,
  filter  = NULL,
  col_t   = NULL,
  col_y   = NULL,
  skip    = 2){

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
  #
  # csv_tv  = "/Users/bbest/github/analysis/data/rvc_grp_years.csv"
  # title   = "Algal Farmers"
  # y_label = "Average count"
  # skip    = 0
  # filter  = "group == Algal farmer"
  # col_t   = "year"
  # col_y   = "q_mean"
  # 
  # x_label = 'Year'
  # v_label = y_label


  library(tidyverse)
  library(dygraphs) # devtools::install_github("rstudio/dygraphs")
  library(xts)
  library(lubridate)

  d = read_csv(csv_tv, skip=skip)

  if (!is.null(filter)){
    d = eval(parse(text=sprintf('filter(d, %s)', filter)))
  }
  
  stopifnot(is.null(col_t) == is.null(col_y))
  
  if(!is.null(col_t)){
    d = d[,c(col_t, col_y)]
  }
  
  #stopifnot(ncol(d) == 2)
  
  colnames(d) = c('t','v')

  if (all(nchar(as.character(d$t))==4)){
    d$t = as.Date(sprintf('%d-01-01', d$t))
  }

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
  #w
  #htmlwidgets::saveWidget(w, file = "w.html", selfcontained = FALSE)
  
  return(w)
}