const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = {
    entry: './src/app.ts',
    resolve: {
        extensions: ['.ts', '.js'],
        modules: [ path.resolve('./node_modules') ],
    },
    devtool: 'source-map',
    module: {
        rules: [
            {
                test: /\.ts$/,
                include: [path.resolve('./src')],
                use: [{ loader: 'ts-loader' }],
            },
        ]
    },
    output: {
        path: __dirname + '/dist',
        publicPath: '/',
        filename: 'bundle.[hash].js'
    },
    plugins: [
        new CleanWebpackPlugin(),
        new HtmlWebpackPlugin({ template: './src/index.html' }),
    ],
    devServer: {
        publicPath: '/',
        contentBase: './src/static',
        stats: {
            children: false,
            modules: false
        }
    }
}