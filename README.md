# In Our Time Downloader

This script parses all the .rss files in a specified directory then attempts to download the enclosed media file to another specified directory. Right now, this works out of the box for the podcast In Our Time.

Here's some known shortcomings:

- A better system would query remote RSS feeds. That way, you wouldn't need to have static files and the feed would be the most recent everytime your run it.
- Several options should be handled as command line arguments, not hard-coded variables.
- The script assumes the enclosed media is an mp3, which is fine for this podcast. It may not be fine for other podcasts.
- When the script checks to see if a file exists, that's all it does. It doesn't check to see if the file is complete.

Potential improvements, which I will get around to if I need to cache another show:

- Allow user to specify output directory in the command line.
- Allow user to specify an rss feed url in the command line.
- Allow a user to specify a file with a list of rss feed urls in the command line.
- Detect the format of the enclosed file being downloaded and adjust accordingly.
- Truly detect if the file has been downloaded already, not just that a file with the right name exists.

Good luck!