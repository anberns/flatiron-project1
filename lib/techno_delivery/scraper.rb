class TechnoDelivery::Scraper
    def scrape 
        listings = []
        html = open("https://hardwax.com/this-week/")
        page = Nokogiri::HTML(html) 
        page.css("div.listing block").each do |listing|
            info_bottom = listing.css("div.linebig")
            new_lising = {
                :artist => info_bottom.css("a").attribute("href").value
                :release => info_bottom.text
            }
        end
        listings << new_listing 
        binding.pry
        listings 
    end
end
