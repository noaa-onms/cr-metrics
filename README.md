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
    
2. Add rows to the **`svg/paths.csv`**:

    habitat     | status_path        | status_color | status_text | link_path     | link                   | link_title
    ------------|--------------------|--------------|-------------|---------------|------------------------|------------
    pelagic     | path#whales        | red          | decreasing  | path#whales   | ./pages/pinnipeds.html | Whales
    pelagic     | g#forage-fish path | green        | increasing  | g#forage-fish | ./pages/pinnipeds.html | Forage Fish
    kelp-forest | path#otter         | purple       | stable      | path#otter    | ./pages/pinnipeds.html | Sea Otters
    
    - **habitat**: the unique name to filter for elements of this habitat scene
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

## TODO

- populate rest of available timeseries from [IEA - California Current](https://www.integratedecosystemassessment.noaa.gov//regions/california-current-region/index.html)
