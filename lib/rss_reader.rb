# encoding: utf-8

require 'rss'
require 'open-uri'
require 'unicode'
require 'json'

NEWS_FOLDER = "artigos"

#http://www.band.uol.com.br/rss/noticias.xml
#http://feeds.folha.uol.com.br/folha/ilustrada/rss091.xml
#url = 'http://rss.uol.com.br/feed/noticias.xml'

def titlelize(title)    
    r = Unicode.downcase(title)
    r.tr!(" \\/:äâàáãêéèëïîìíüúùûôöóòõç", "____aaaaaeeeeiiiiuuuuoooooc")
    r.tr!("!@#$%&*()-,;'\"", "")
    r
end

urls = { 
    'G1' => 'http://fulltextrssfeed.com/g1.globo.com/dynamo/rss2.xml',
    'Economist' => 'http://fulltextrssfeed.com/www.economist.com/feeds/print-sections/74/international.xml',
    'FinancialTimes' => 'http://fulltextrssfeed.com/www.ft.com/rss/world'
}

path = File.join(Dir.pwd, NEWS_FOLDER)

while 1 do
    
    Dir.mkdir(path, 0700) unless Dir.exists?(path)

    urls.each do |name, url|
    
        begin
    
            path2 = File.join(path, name)    
            Dir.mkdir(path2, 0700) unless Dir.exists?(path2)

            puts "Name: #{name} - #{url}"

            open(url) do |rss|

                feed = RSS::Parser.parse(rss, false)

                feed.items.each do |item|

                    filename = "#{path2}/#{titlelize(item.title)}.txt"

                    next if File.exists?(filename)

                    puts "Adding #{filename} ..."

                    File.open(filename, "w+", :encoding => "utf-8") do |file|
                        file << { 
                            :title => item.title, 
                            :content => item.description, 
                            :link => item.link }.to_json
                    end

                end

            end

        rescue => e
            puts "Error: #{e}"
        end

    end

    sleep 300

end
