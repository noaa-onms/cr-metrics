# Notes

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
/usr/bin/open -a '/Applications/Google Chrome.app' 'http://localhost:8000/pelagic.html'

# kill web server
ps -eaf | grep http.server
kill ...
```

* [An SVG primer — Scott Murray — alignedleft](http://alignedleft.com/tutorials/d3/an-svg-primer)
* [D3 - A Beginner's Guide to Using D3](http://website.education.wisc.edu/~swu28/d3t/concept.html)

## JS

- [Getting started - Grunt: The JavaScript Task Runner](http://gruntjs.com/getting-started#package.json)
- [install | npm Documentation](https://docs.npmjs.com/cli/install)
- [sapegin/grunt-bower-concat: Bower components concatenator for Grunt](https://github.com/sapegin/grunt-bower-concat)
