/*jshint esversion: 6 */
"use strict";

const webpack = require('webpack');
const path = require('path');
const BabiliPlugin = require("babili-webpack-plugin");

module.exports = [
    {
        entry: './node_modules/fengari-web-cli/src/web-cli-lua.js',
        output: {
            path: path.resolve(__dirname, 'static/js'),
            filename: 'fengari-web-cli.js',
            library: 'fengari_web_cli'
        },
        plugins: [
            new webpack.DefinePlugin({
                WEB: JSON.stringify(true),
            }),
            new BabiliPlugin()
        ]
    }
];
