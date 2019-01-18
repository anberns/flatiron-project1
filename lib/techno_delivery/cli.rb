require 'fileutils'
include Process

class TechnoDelivery::CLI

    # creates crate object from scrape, starts CLI
    def call
      crate = TechnoDelivery::Scraper.new.scrape
      puts "\nTechno Delivery!\n\nFresh tracks from Hard Wax ready for sampling.\n\n"
      start(crate)
    end

    # primary menu of the CLI
    def start(crate)
        puts "What are you in the mood for?" 
        puts "1. Techno Proper\n2. Electro\n3. House\n4. Atmospheric\n5. Highly Recommeneded\n6. Other\n7. All\n"
        input = gets.strip
        input_i = input.to_i
        acceptable_answers = (1..7).to_a
        while !acceptable_answers.any? { |answer| answer == input_i }
            puts "\nI'm sorry, that's not a valid option."
            puts "Please enter a number from 1 - 7."
            input_i = gets.strip.to_i
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
        self.listen?(tracks, crate)
    end

    # secondary menu of CLI for listening options
    def listen?(tracks, crate)
        puts "\n\nListen to tracks?\n1. Yes\n2. No"
        input = gets.strip
        input_i = input.to_i
        acceptable_answers = (1..2).to_a
        while !acceptable_answers.any? { |answer| answer == input_i }
            puts "\nI'm sorry, that's not a valid option."
            puts "Please enter 1 or 2."
            input_i = gets.strip.to_i
        end 

        if input_i == 1
            self.play_tracks(tracks)
            self.again_or_exit?(crate)
        else 
            self.again_or_exit?(crate)
        end
    end 

    # third menu, exit or repeat
    def again_or_exit?(crate)
        puts "\n\nWhat would you like to do now?\n1. View another genre.\n2. Exit"
        input = gets.strip
        input_i = input.to_i
        acceptable_answers = (1..2).to_a
        while acceptable_answers.none? { |answer| answer == input_i }
            puts "\nI'm sorry, that's not a valid option."
            puts "Please enter 1 or 2."
            input_i = gets.strip.to_i
        end 

        if input_i == 1
            self.start(crate)
        else
            puts "Have a good one!"
        end
    end 

    # access crate object's releases attribute and collects those
    # with chosen subgenre
    def get_tracks(crate, subgenre)
        releases = crate.gather_releases_by_subgenre(subgenre)
    end

    # display release information of chosen subgenre 
    def display_releases(releases)
        url = ""
        releases.each do |release|
            puts "\n\n#{release.name} by #{release.artist} on #{release.label}\n"
            release.tracks.each_with_index do |track, index|
                puts "-#{track.name}"
                url = track.url
            end
        end
    end

    # utilizes fork and exec to play and skip samples
    def play_tracks(releases)
        puts "\n***Press enter to skip***"
        releases.each do |release|
            release.tracks.each do |track|
                puts "Playing-> #{release.name} - #{track.name}"
                begin
                    tempfile = URI.parse(track.url).open
                    tempfile.close
                    FileUtils.mv tempfile.path, "audio.mp3"
                rescue
                    puts "Error: Something went wrong with the sample download."
                    exit(1)
                end
                pid = fork{ 
                    begin
                        exec 'afplay', "audio.mp3"
                    rescue 
                        puts "Error: Something went wrong with sample playback."
                        exit(1)
                    end
                }
                pid2 = fork{ 
                    input = gets 
                    kill(1, pid)
                }
                waitpid2(pid, 0) 
                kill(1, pid2)
                if $?.exitstatus == 1 || 255
                    break
                end
            end
        end
    end

end