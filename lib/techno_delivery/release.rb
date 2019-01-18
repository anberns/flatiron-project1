class TechnoDelivery::Release 

    attr_accessor :name, :artist, :label, :country, :subgenre, :tracks, :crate

    @@all = []

    def initialize(release_hash, crate)
        @name = release_hash[:name]
        @artist = release_hash[:artist]
        @label = release_hash[:label]
        @country = release_hash[:country]
        @subgenre = release_hash[:subgenre]
        @tracks = self.create_tracks(release_hash[:tracks]) 
        @crate = crate
        @@all << self
    end

    def self.all 
        @@all 
    end

    def self.create_from_hash(release, crate)
        new_release = TechnoDelivery::Release.new(release, crate)
    end

    def create_tracks(tracks)
        track_objects = []
        tracks.each do |track|
            track_objects << TechnoDelivery::Track.create_from_hash(track, self)
        end
        track_objects
    end

end