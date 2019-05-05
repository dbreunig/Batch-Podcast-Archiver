require 'feedjira'
require 'open-uri'

Feedjira::Parser::ITunesRSSItem.class_eval do
    # A consistent method for filenames based on titles, since these will function as hashkeys
    def filename
        "#{self.title.gsub(' ','_').gsub(/\_$/, '')}.mp3"
    end
end

# Source: http://gavinmiller.io/2016/creating-a-secure-sanitization-function/
# Modified: Removed '.' from bad chars
def sanitize(filename)
    # Bad as defined by wikipedia: https://en.wikipedia.org/wiki/Filename#Reserved_characters_and_words
    # Also have to escape the backslash
    bad_chars = [ '/', '\\', '?', '%', '*', ':', '|', '"', '<', '>', ' ' ]
    bad_chars.each do |bad_char|
      filename.gsub!(bad_char, '_')
    end
    filename
end
  
# Where the RSS files are located
target_dir      = 'rss'
# Where you're saving the mp3s
download_dir    = 'mp3'
# The unique list of filenames and urls to download
@download_urls  = Hash.new()

# Clean all the RSS
Dir.entries(target_dir).each do | filename | # Make this a command line argument
    next unless filename =~ /.rss$/ 
    file        = File.open("#{target_dir}/#{filename}", "rb")
    contents    = file.read
    feed        = Feedjira::Feed.parse(contents)
    feed.entries.each do | entry |
        @download_urls[sanitize(entry.filename)] = entry.enclosure_url
    end
end

# Download the files
@download_urls.each do | filename, url |
    file_location = "#{download_dir}/#{filename}"
    # Check if exists
    if File.file?(file_location)
        puts "#{filename} exists."
        next
    end
    # Print status
    puts "Downloading #{filename}..."
    # Download
    File.open(file_location, "wb") do | file |
        file.write(open(url).read)
    end
    # Have a heart
    sleep(3)
end