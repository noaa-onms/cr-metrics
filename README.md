# CRmetrics

Condition Report metrics to inform National Marine Sanctuaries

## By Sanctuary

[Florida Keys Sanctuary](http://floridakeys.noaa.gov/)


## Interactive Infographic

- data: [IEA - California Current Integrated Ecosystem Assessment (CCIEA)](http://www.noaa.gov/iea/regions/california-current-region/index.html)

    - [Marine Mammals](http://www.noaa.gov/iea/regions/california-current-region/indicators/marine-mammals.html)

Strategy:

- fullscreen background
- SVG icons colored by status
- parameterized reports to generate:
  - CSS for color of SVG icons
  - modal dygraph popups
- website menu
- iframe is the key!
  
## Debug

```bash
# launch web server
cd '/Users/bbest/github/cr-metrics'; python -m http.server 8000 &

# open in browser
/usr/bin/open -a '/Applications/Google Chrome.app' 'http://localhost:8000/proto.html'

# kill web server
ps -eaf | grep http.server
kill ...
```