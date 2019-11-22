# Author: Patrice Harapeti

require 'fileutils'
require 'etc'

def parse_year(year)
  year.to_s.chars.last(2).join
end

def username
    Etc.getlogin
end

def join_to_os(path)
  "/Users/#{username}/Desktop/Daily/" + path
end

filesSorted = 0

Dir["/Users/#{username}/Desktop/Daily/*"].each do |file|
  next if File.directory? file

  last_modified = File.mtime(file)
  day = last_modified.day
  month = last_modified.month
  year = last_modified.year

  file_name = File.basename(file)
  file_path = join_to_os("#{day}:#{month}:#{parse_year(year)}")
  new_file_path = "#{file_path}/#{file_name}"

  if Dir.exist? file_path
    FileUtils.mv(file, new_file_path)
  else
    FileUtils.mkdir_p file_path
    FileUtils.mv(file, new_file_path)
  end
  
  filesSorted = filesSorted.next
  
  # Print every 4 file moves; just so we know the script isn't hanging
  if filesSorted % 4 == 0
      puts 'Organising...'
  end
end

if filesSorted > 0
    puts 'Files are now organised and ready for upload.'
else
    puts 'No files needed to be sorted'
end
