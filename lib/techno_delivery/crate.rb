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

    def self.create_from_scrape(week_data)
        crate = TechnoDelivery::Crate.new(week_data[:week])
        week_data[:releases].each do |release|
            new_release = TechnoDelivery::Release.create_from_hash(release, crate.week)
            crate.releases << new_release
        end
        crate
    end

    def gather_releases_by_subgenre(subgenre)
        check = self.releases 
        collected = [] 
        self.releases.each do |release|
            collected << release if release.subgenre == subgenre
        end
        collected 
    end

end