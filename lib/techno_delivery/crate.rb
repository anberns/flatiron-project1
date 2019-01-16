class TechnoDelivery::Crate 

    # has many releases
        # has several tracks 
    attr_accessor :week, :releases

    @@all = []

    def initialize(week)
        @week = week
        @releases = []

        @@all << self
    end

    #week_data = {:week => "date", :releases => [Release objects]}
    def self.create_from_scrape(week_data)
        crate = Crate.new(week_data.week)
        week_data.releases.each do |release|
            new_release = Release.create_from_hash(release, crate)
            crate.releases << new_release
        end
        crate
      end
end