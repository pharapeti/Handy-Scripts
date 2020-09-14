Dir.glob("**/*.html.haml") do |filename|
    name = filename.split('.html.haml').first
    new_filename = name + '.haml'

    puts "Renaming #{filename} to #{new_filename} ..."
    File.rename(filename, new_filename)
end
