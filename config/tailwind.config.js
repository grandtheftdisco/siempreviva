const plugin = require('tailwindcss/plugin')

module.exports = {
  content: [
    "./app/views/**/*.{erb,html,html.erb,haml,slim}",
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.rb', // If using ViewComponents
    "./app/assets/stylesheets/**/*.css",
  ],
  theme: {
    extend: {
      // Note: Custom colors (sv-*) are defined using Tailwind v4 @theme directive
      // in app/assets/tailwind/application.css, not here.
      // This config file is still needed for content paths and plugins.
    },
  },
  plugins: [
    // Add orientation variants for portrait/landscape-specific styling
    plugin(function({ addVariant }) {
      addVariant('portrait', '@media (orientation: portrait)')
      addVariant('landscape', '@media (orientation: landscape)')
    })
  ],
};