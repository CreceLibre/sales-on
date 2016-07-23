var path = require("path");

module.exports = {
    entry: {
        app: [
            './frontend/index.js'
        ]
    },

    output: {
        path: path.resolve(__dirname + '/public'),
        filename: '[name].js',
    },

    module: {
        loaders: [
          { test: /\.css$/, loader: 'style!css'},
          { test: /\.styl$/, loader: 'style!css!stylus'},
          { test: /\.html$/, exclude: /node_modules/, loader: 'file?name=[name].[ext]'},
          { test: /\.elm$/, exclude: [/elm-stuff/, /node_modules/], loader: 'elm-webpack'},
          { test: /\.woff(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=10000&minetype=application/font-woff" },
          { test: /\.woff2(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=10000&minetype=application/font-woff" },
          { test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" }
        ],
        noParse: /\.elm$/,
    },

};
