class TechnoDelivery::Track 

    attr_accessor :name, :url
    attr_reader :release

    @@all = []

    def initialize(track_hash, release)
        track_hash.each {|key, value| self.send(("#{key}="), value)}
        @release = release 
    end

    def self.create_from_hash(track_hash, release)
        new_track = TechnoDelivery::Track.new(track_hash,release)
        @@all << new_track 
        new_track
    end

    def self.all
        @@all 
    end

end 