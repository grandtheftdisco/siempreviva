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
      // Note: Custom colors (sv-*) are defined using Tailwind v4 @theme directive
      // in app/assets/tailwind/application.css, not here.
      // This config file is still needed for content paths and plugins.
    },
  },
  plugins: [
    require('flowbite/plugin')
  ],
};