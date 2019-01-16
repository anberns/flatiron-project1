class TechnoDelivery::Scraper
    def scrape 
        week_data = {
            :date = "1/1/19" # find source
            :releases = []
        }

        html = open("https://hardwax.com/this-week/")
        page = Nokogiri::HTML(html) 
        page.css("div.listing block").each do |release|
            a_hrefs = []
            data = release.css("div.linesmall")
            subgenre = self.parse_subgenre(data.css("p").text)
            a_hrefs << data.css("a").attribute("href").value
            release_object = {
                :label => a_hrefs[0],
                :country => a_hrefs[2]
                :subgenre => subgenre
            }
            tracks = []
            tracks_data = data.css("a.download_listen")
            tracks_data.each do |track_data|
                track = {
                    :url => track_data.attribute("href").value
                    :name => track_data.text 
                }
                tracks << track
            end
            
            release_object[:tracks] = tracks
            other_data = release.css("div.linebig")
            release_object[:name] = other_data.css("a").attribute("href").value
            release_object[:artist] = other_data.text
            week_data[:releases] << release_object
        end

        # week_data = {:week => "date", :releases => [release objects]}
        Crate.create_from_scrape(week_data)
    end

    def parse_subgenre(description)
        # add logic to pull subgenre from desc
        "techno"
    end
end

# release_object => :name, :artist, :label, :country, :subgenre, :tracks, :crate
