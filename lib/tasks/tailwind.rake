# # this nomenclature avoids overriding the tailwind gem's `build` task
# namespace :my_tailwindcss do
#   desc "Build Tailwind CSS"
#   task :build do
#     # Remove any existing tailwind.css to prevent conflicts
#     FileUtils.rm_f(Rails.root.join("app/assets/builds/tailwind.css"))
#     # Run the Tailwind CSS build with the correct input and output
#     system "bin/tailwindcss -i app/assets/stylesheets/application.tailwind.css -o public/assets/tailwind.css --minify"
#   end
# end

# # `enhance` ensures that the custom build task above runs before the rest of `assets:precompile`
# Rake::Task["assets:precompile"].enhance(["my_tailwindcss:build"])


# Clear the default tailwindcss:build task to prevent it from running
if Rake::Task.task_defined?("tailwindcss:build")
  Rake::Task["tailwindcss:build"].clear
end

# Define your custom namespace and build task
namespace :my_tailwindcss do
  desc "Build Tailwind CSS with custom input and output"
  task :build do
    # Remove any existing output file to avoid conflicts
    FileUtils.rm_f(Rails.root.join("public/assets/tailwind.css"))
    # Run the Tailwind CSS build command with your specific input and output
    # the -o flag denotes output stream - outputting to this path since Propshaft
    # expects assets in `app/assets/builds/` for precompilation
    system "bin/tailwindcss -i app/assets/stylesheets/application.tailwind.css -o app/assets/builds/tailwind.css --minify"
  end
end

# Redefine the tailwindcss:build task to point to your custom task
task "tailwindcss:build" => ["my_tailwindcss:build"]

# Hook your custom task into assets:precompile
Rake::Task["assets:precompile"].enhance(["my_tailwindcss:build"])