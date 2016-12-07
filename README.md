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
/usr/bin/open -a '/Applications/Google Chrome.app' 'http://localhost:8000/index.html'

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
```
# create package.json
cd ~/github/cr-metrics
npm init

# add d3 package locally
npm install d3 --save-dev
npm install d3-dsv --save-dev

#
npm install grunt-bower-concat --save-dev

# Installing Grunt and gruntplugins
npm install grunt --save-dev
npm install grunt-contrib-jshint --save-dev
```

# Grunt ...

The following command overwrote above...

```bash
grunt-init --force jquery
```

# Cr Metrics

The best jQuery plugin ever.

## Getting Started
Download the [production version][min] or the [development version][max].

[min]: https://raw.github.com/marinebon/cr-metrics/master/dist/cr-metrics.min.js
[max]: https://raw.github.com/marinebon/cr-metrics/master/dist/cr-metrics.js

In your web page:

```html
<script src="jquery.js"></script>
<script src="dist/cr-metrics.min.js"></script>
<script>
jQuery(function($) {
  $.awesome(); // "awesome"
});
</script>
```

## Documentation
_(Coming soon)_

## Examples
_(Coming soon)_

## Release History
_(Nothing yet)_
