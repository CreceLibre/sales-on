'use strict'

// PureCSS styles
require('purecss/build/pure-min.css');
require('purecss/build/grids-responsive-min.css');
require('purecss/build/buttons-min.css');
require('./main.styl');

// Font-Awesome
require('font-awesome-webpack');

require('./index.html');

var Elm = require('./Main.elm');

var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
