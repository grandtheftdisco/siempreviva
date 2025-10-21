module.exports = {
  content: [
    "./app/views/**/*.{erb,html,html.erb,haml,slim}",
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.rb', // If using ViewComponents
    "./app/assets/stylesheets/**/*.css",
    "./node_modules/flowbite/**/*.js"
  ],
  theme: {
    extend: {
      colors: {
        // Siempreviva custom color palette
        'sv-purple': {
          100: '#f0e8f5', // background-purple
          200: '#e6d3ec', // button-purple
          400: '#c5aace', // primary-purple, light-purple
          700: '#674174', // button-hover-purple, primary-purple (darker)
        },
        'sv-green': {
          200: '#bdcea9', // light-green
          400: '#8ba170', // primary-green
          600: '#698b3f', // button-green
          700: '#4f5e3c', // button-hover-green
        },
        'sv-pink': {
          200: '#f7c8d8', // light-pink
          400: '#f4a5c2', // medium-pink
        },
        'sv-gray': {
          100: '#f8f9fa', // light-bg
          400: '#adb5bd', // light-text
          500: '#6c757d', // medium-text
          800: '#2c3e50', // dark-text
        },
        // Semantic/action colors
        'sv-success': '#5a8664',
        'sv-warning': '#c19550',
        'sv-danger': '#b9626b',
        'sv-info': '#6b9fa8',
      },
    },
  },
  plugins: [
    require('flowbite/plugin')
  ],
};