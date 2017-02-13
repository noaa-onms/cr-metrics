# cr-metrics

Condition Report metrics to inform on National Marine Sanctuaries status using interactive infographic approach to displaying habitat-based elements that link to time series data. Proposed by Jenn Brown (2016).

## Process

Given a vector illustration of habitat scenes with different elements (eg pelagic: whales, fish, etc), running the following R code will generate the website for pulling up timeseries plots by clicking on the elements:

```R
# create pages
source('functions.R')
create_site()

# serve locally 
servr::httd('docs')
```

Besides the habitat illustration as a scalable vector graphics file (eg [pelagics.svg](https://github.com/marinebon/cr-metrics/blob/master/svg/pelagic.svg)), the `create_site()` function relies on two tables in comma-seperated value (\*.csv) format:

- [**elements.csv**](https://github.com/marinebon/cr-metrics/blob/master/svg/elements.csv): identifies the elements in the svg habitat scene(s)
- [**indicators.csv**](https://github.com/marinebon/cr-metrics/blob/master/svg/indicators.csv): provides the ERDDAP URL to the timeseries data and other parameters to describe the timeseries plots and match to the svg element

The website content is output to the `docs/` folder, providing an interactive user experience with only basic web files (\*.html, \*.js, \*.css) that any web server can host.

You can see the files for this site hosted on Github here:

- https://github.com/marinebon/cr-metrics

Please visit [Help & Documentation for MBON - Applications - Interactive Infographics](https://marinebon.github.io/help/apps.html#interactive-infographics) for more background.

Here are detailed steps to prep the necessary files (svg scenes, csv tables of elements and indicators)...

1. Download and unzip the template site here:

- https://github.com/marinebon/cr-metrics/archive/master.zip

1. Edit the vector graphics file of the habitat scene with elements using the free [Inkscape](http://inkscape.org) program that natively uses scalable vector graphics (`*.svg`) format:
    - remove text labels
    - add **ID** to element or group of elements:
    
        ![](img/inkscape-screenshot_svg-id.png)
    - save to folder `svg/*.svg` as "Plain SVG" (such as `svg/pelagic.svg`)
    
2. Add rows to the **`svg/elements.csv`**:

    habitat     | id          | status_path        | status_color | status_text | link_path     | link                   | link_title
    ------------|-------------|-----------------|--------------|-------------|---------------|------------------------|------------
    pelagic     | whales      | path#whales        | red          | decreasing  | path#whales   | ./pages/pinnipeds.html | Whales
    pelagic     | forage-fish | g#forage-fish path | green        | increasing  | g#forage-fish | ./pages/pinnipeds.html | Forage Fish
    kelp-forest | otters      | path#otters         | purple       | stable      | path#otter    | ./pages/pinnipeds.html | Sea Otters
    
    - **habitat**: the unique name to filter for elements of this habitat scene
    - **id**: unique element identifier
    - **status_path**: the SVG path, either `path#element` (eg `path#whales`) for single element, or `g#element path` for grouped elements (eg `g#forage-fish path`)
    - **status_color**: the color of the element reflecting the status
    - **status_text**: the text of the element reflecting the status that appears on hover
    - **link_path**: the SVG path, either `path#element` (eg `path#whales`) for single element, or `g#element` for grouped elements (eg `g#forage-fish`)
    - **link**: the hyperlink to the page of corresponding data (usually timeseries)
    - **link_title**: the title that shows at the top of the modal popup window containing the page when the element is clicked

3. Add / edit the `indicators.csv` with the following key fields, originally drawn from the site [IEA - California Current](https://www.integratedecosystemassessment.noaa.gov//regions/california-current-region/index.html):

    - **indicator**: name of indicator, which will become the timeseries plot's title
    - **y_label**: label on the y-axis describing the value measured over time
    - **csv_url**: the link to the ERDDAP data in CSV format, extractable from the ERDDAP image URL
    
4. Create the site by running the following R code:

    ```R
source('functions.R')
create_site()
```
    - Be sure that your current working directory is in the `cr-metrics/` root folder (eg with `setwd()` in R).

    The website gets built into the `docs/` folder.

5. Push to website. This repository uses Github Pages:

    - code: https://github.com/marinebon/cr-metrics

    - site: https://marinebon.github.io/cr-metrics

## TODO

- Populate California example, using available ERDDAP-connected timeseries from [IEA - California Current](https://www.integratedecosystemassessment.noaa.gov//regions/california-current-region/index.html)

- Populate Florida Keys NMS, working in particular with people at FKNMS (Mike Buchman, Steve Gittings) and FL MBON (Megan Hepner)
