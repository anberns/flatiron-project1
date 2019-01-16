class TechnoDelivery::Release 

    # has several tracks
    attr_accessor :name, :artist, :label, :country, :subgenre, :tracks, :crate

    @@all = []

    def initialize(release_hash, crate)
        release_hash.each {|key, value| self.send(("#{key}="), value)}
        @tracks = self.create_tracks(@tracks) 

        @@all << self
    end

    def self.create_from_hash(releases, crate)
        releases.each do |release|
            new_release = Release.new(release, crate)
        end
    end

    def create_tracks(tracks)
        track_objects = []
        tracks.each do |track|
            track_objects << Track.create_from_hash(track, self)
        end
        track_objects
    end

end