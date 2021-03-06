module.exports = {
  /*
  ** Headers of the page
  */
  head: {
    title: 'vue-wordpress',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Vue + Wordpress project' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  /*
  ** Customize the progress bar color
  */
  loading: { color: '#3B8070' },
  /*
  ** Build configuration
  */
  build: {
    postcss: {
      plugins: {
        'postcss-nested': {}
      },
      preset: {
        features: {
          'nesting-rules': true
        }
      }
    },
    extractCSS: true,
    extend: (config) => {
      const svgRule = config.module.rules.find(rule => rule.test.test('.svg'));
 
      svgRule.test = /\.(png|jpe?g|gif)$/;
 
      config.module.rules.push({
        test: /\.svg$/,
        oneOf: [
          {
            resourceQuery: /inline/,
            loader: 'vue-svg-loader',
          },
          {
            loader: 'file-loader',
            query: {
              name: 'assets/[name].[hash:8].[ext]',
            },
          },
        ],
      });
    },
    /*
    ** Run ESLint on save
    */
    /* extend (config, { isDev, isClient }) {
      if (isDev && isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    } */
  },
  modules: [
    '@nuxtjs/axios',
  ],
  axios: {
    baseURL: 'http://wp:8080',
    browserBaseURL: process.env.NODE_ENV === 'development' ? 'http://localhost:5000' : 'http://[YOUR_HOST_IP_OR_DOMAIN]:5000'
  },
  sentry: {
    public_key: 'YOUR_PUBLIC_KEY',
    project_id: 'YOUR_PROJECT_ID',
    config: {
      // Additional config
    },
  },
}

