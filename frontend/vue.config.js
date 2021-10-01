// May be useful for running the dev server on a remote host
const publicIp = "http://127.0.0.1:8080"

module.exports = {
    publicPath: process.env.NODE_ENV === 'production' ? '/static/dist/' : publicIp,
    outputDir: './build/dist',

    // relative to outputDir!
    indexPath: '../templates/base-vue.html',

    configureWebpack: {
        devServer: {
            watchOptions: {
                ignored: ['node_modules'],
                aggregateTimeout: 300,
                poll: 300
            },
            public: publicIp,
            disableHostCheck: true,
            hotOnly: true,
            headers: {"Access-Control-Allow-Origin": "*"},
            writeToDisk: (filePath => filePath.endsWith('index.html'))
        }
    },

    transpileDependencies: [
      'vuetify'
    ]
}
