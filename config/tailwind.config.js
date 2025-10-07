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
    extend: {},
  },
  plugins: [
    require('flowbite/plugin')
  ],
};