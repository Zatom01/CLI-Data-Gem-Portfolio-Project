
class Movie

    @@all=[]

    attr_accessor :name

    def initialize(name)
        @name=name
        @@all << self
    end


    def self.all
        @@all
    end

    def self.find_movie(index)
        movie=@@all[index-1]
        return movie.name
    end

    def self.destroy_all
        @@all.clear
    end
end
