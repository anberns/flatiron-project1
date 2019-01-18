require "pry"
class TechnoDelivery::Scraper
    def scrape 
        d = DateTime.now
        d.strftime("%d/%m/%Y")
        week_data = {
            :week => d,
            :releases => []
        }
        urls = [
            "https://hardwax.com/this-week/",
            "https://hardwax.com/this-week/?page=2"
        ]
        urls.each do |url|
            html = open(url)
            page = Nokogiri::HTML(html) 
            records = page.xpath('//div[starts-with(@id, "record")]')
            records.each do |release|
                a_hrefs = []
                release_object = {}
                data = release.css("div.linesmall")
                subgenre = self.parse_subgenre(data.css("p").text)
                data.css("a").each do |txt|
                    a_hrefs << txt.text 
                end
                release_object = {
                    :label => a_hrefs[0],
                    :country => a_hrefs[2],
                    :subgenre => subgenre
                }
                tracks = []
                tracks_data = data.css("a.download_listen")
                tracks_data.each do |track_data|
                    track = {
                        :url => track_data.attribute("href").value,
                        :name => track_data.text 
                    }
                    tracks << track
                end
                
                release_object[:tracks] = tracks
                other_data = release.css("div.linebig")
                release_artist, release_name = other_data.text.split(":")
                self.force_strip(release_name)
                release_object[:name] = release_name
                release_object[:artist] = release_artist.gsub(/:/, "")
                week_data[:releases] << release_object
            end
        end

        TechnoDelivery::Crate.create_from_scrape(week_data)
    end

    def force_strip(str)
        str[0] = ""
    end

    def parse_subgenre(description)
        subgenres = [
            [
                "highly",
                "recommended",
                "recommend"
            ],
            [
                "ambient",
                "dreamy",
                "spaced out",
                "spacy",
                "deep",
                "space",
                "atmospheric",
                "mesmerizing"
            ],
            [
                "hard",
                "banging",
                "driving",
                "stomping",
                "boomy",
                "big room",
                "techno"
            ],
            [
                "electro"
            ],
            [
                "house"
            ]
        ]
        subgenre_titles = [
            "recommended", "atmospheric", "techno proper", "electro" 
        ]
        return self.find_subgenre(subgenres, subgenre_titles, description)
   end

    def find_subgenre(subgenres, subgenre_titles, description) 
        description.downcase!
        subgenres.each_with_index do |subgenre, index|
            subgenre.each do |word|
                if description.include?(word)
                    return subgenre_titles[index]
                end
            end
        end
        return "other"
    end

end
