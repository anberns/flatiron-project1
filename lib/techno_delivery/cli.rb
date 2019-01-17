class TechnoDelivery::CLI

    def call
      crate = TechnoDelivery::Scraper.new.scrape
      puts "\nTechno Delivery!\n\nFresh tracks from Hard Wax ready for perusal.\n\n"
      start(crate)
    end

    def start(crate)
        puts "What are you in the mood for?" 
        puts "1. Techno proper\n2. Electro\n3. House\n4. Atmospheric\n5. Highly recommeneded\n6. Other\n7. All\n"
        input = gets.strip
        input_i = input.to_i
        acceptable_answers = (1..7).to_a
        while acceptable_answers.none? { |answer| answer == input_i } == true
            puts "\nI'm sorry, that's not a valid option."
            puts "Please enter a number from 1 - 7."
            input = gets.strip
        end
        
        tracks = []
        case input_i
            when 1
                tracks = self.get_tracks(crate, "techno proper")
            when 2 
                tracks = self.get_tracks(crate, "electro")
            when 3
                tracks = self.get_tracks(crate, "house")
            when 4
                tracks = self.get_tracks(crate, "atmospheric")
            when 5
                tracks = self.get_tracks(crate, "recommended")
            when 6
                tracks = self.get_tracks(crate, "other")
            when 7
                tracks = crate.releases
            end

        self.display_releases(tracks)

        puts "\n\n1. View another genre.\n2. Exit"
        input = gets.strip
        input_i = input.to_i
        acceptable_answers = (1..2).to_a
        while acceptable_answers.none? { |answer| answer == input_i }
            puts "\nI'm sorry, that's not a valid option."
            puts "Please enter 1 or 2."
            input = gets.strip
        end 

        if input_i == 1
            self.start(crate)
        else 
            puts "Have a good one!"
        end

    end 

    def get_tracks(crate, subgenre)
        releases = crate.gather_releases_by_subgenre(subgenre)
    end

    def display_releases(releases)
        releases.each do |release|
            puts "\n\n#{release.name}"
            puts "-by #{release.artist} on #{release.label}\n"
            release.tracks.each_with_index do |track, index|
                puts "\n\t#{index + 1}. #{track.name}\n\t#{track.url}"
            end
        end
    end


end