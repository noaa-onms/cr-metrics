# cr-metrics

Condition Report metrics to inform on National Marine Sanctuaries status using interactive infographic approach to displaying habitat-based elements that link to time series data. Proposed by Jenn Brown (2016).

## Process

The process is fairly straightfoward to integrate:

- **habitat illustration**: vector rendering of habitat with elements (species or other)

- **data pages**: timeseries plots or maps of data

Please visit [Help & Documentation for MBON - Applications - Interactive Infographics](https://marinebon.github.io/help/apps.html#interactive-infographics) for more background.

1. Edit the Adobe Illustrator file (`*.ai`) using the free [Inkscape](http://inkscape.org) program that natively uses scalable vector graphics (`*.svg`) format:
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

3. Create a new habitat.Rmd page:

    - Copy existing habitat.Rmd (such as `pelagic.Rmd`) and save as new *.Rmd
    - Update parameters at top of page to reflect the filter to the 
    
        ```yaml
---
title: "Kelp Forest"
params:
   svg:    "./svg/kelp-forest.svg"
   filter: "kelp-forest"
---
```

4. Build Website. There's either a button in RStudio under the Build tab, or you can use the R command:

    ```R
rmarkdown::render_site()
```

    The website gets built into the `docs/` folder.

5. Push to website. This repository uses Github Pages:

    - code: https://github.com/marinebon/cr-metrics

    - site: https://marinebon.github.io/cr-metrics

## TODO

- Populate California example, using available ERDDAP-connected timeseries from [IEA - California Current](https://www.integratedecosystemassessment.noaa.gov//regions/california-current-region/index.html)

- Populate Florida Keys NMS, working in particular with people at FKNMS (Mike Buchman, Steve Gittings) and FL MBON (Megan Hepner)
