# Use Nokogiri XML parser
require 'nokogiri'
# Create new file to export to
newname = "newmap"
export = File.new("export/" + newname + ".xml","w+")
export.puts '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

# Open XML
f = File.open("import/" + "sitemap.xml")
@data = Nokogiri::XML(f)
f.close

urls = @data.css("url")

# Loop through URLs and save them to the new file
i = 1
j = 1
filecount = 40000
urls.each do |url|
	if ( i < filecount )
		export.puts url
		i += 1
	elsif ( i == filecount )
		export.puts '</urlset>'
		export.close
		newname = "newmap" + j.to_s
		export = File.new("export/" + newname + ".xml","w+")
		export.puts '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
		i = 1
		j += 1
	end
end
export.puts '</urlset>'
export.close