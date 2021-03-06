require 'open-uri'
require 'nokogiri'

#byebug continue!

class Detail

    URL= "https://www.hulu.com/movies"
    html=URI.open(URL)
    @@doc1=Nokogiri::HTML(html)

    def initialize(category_index,movie_index)
        @category_index=category_index-1
        @movie_index=movie_index-1
        @link={:link=>[], :title=>[],:description=>[],:genre=>[]}
    end

    def print_details
        movie_link
        movie_title
        movie_genre
        movie_description

    end

    def movie_link
        @link[:link] << "https://www.hulu.com"+@@doc1.css('.SimpleCollection')[@category_index].css('a.Tile__title-link')[@movie_index].attributes['href'].value
        puts "Movie Link : #{@link[:link][0]}"

    end

    def movie_title
        @link[:title] << Nokogiri::HTML(URI.open(@link[:link][0])).css('h1.DetailEntityMasthead__title').text
        puts "Movie Title : #{@link[:title][0]}"
    end

    def movie_genre
        @link[:genre] << Nokogiri::HTML(URI.open(@link[:link][0])).css('div.DetailEntityMasthead__tags').text
        puts "Movie Genre : #{@link[:genre][0]}"
    end

    def movie_description
        @link[:description] << Nokogiri::HTML(URI.open(@link[:link][0])).css('p.DetailEntityModal__description').text
        puts "Movie Description : #{@link[:description][0]}"
    end

end
