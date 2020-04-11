require 'open-uri'
require 'nokogiri'
require_relative 'detail.rb'
require_relative 'movie.rb'

class Scraper

    URL = "https://www.hulu.com/movies"
    html=URI.open(URL)
    @@doc1=Nokogiri::HTML(html)
    @@categories_node = @@doc1.css('h2.jsx-3585791598.SimpleCollection__title')

    def list_categories
        categories_arr=[] #categories array
        @@categories_node.each do |category|
            categories_arr << category.text
        end

        print "Would you like to see HULU movies categories? Enter Y or N : "
        input=gets.chomp.upcase

        if input == "Y"
            puts "\nYou chose YES\n"
            puts "\nHulu Movies Categories:\n"

            #displays Hulu movie categories
            categories_arr.each do |each|
                puts"#{categories_arr.index(each)+1}. #{each}"
            end

            print "\n Choose category. Enter one valid number :"
            @category_index=gets.chomp
            @category_index=@category_index.to_i

            puts "\nYou chose #{@category_index}. #{categories_arr[@category_index-1]}"
            puts " "

            #position of a particular category in a 2-D matrix
            #categories=["newly_added=[...movies...], "featured =[...]", "Hulu Originals=[...]",......]
            list_movies(@category_index)

        end

    end

    def list_movies(x,y=0)

        #checks the array size of the selected category
        cat_arr_size=@@doc1.css('.NonSubSimpleCollection.cu-non-sub-simple-collection')[x-1].css('a.Tile__title-link').css('div').size

        #y=sub array index of the category. increments by 1
        counter=0
        while counter < cat_arr_size
            movie=@@doc1.css('.NonSubSimpleCollection.cu-non-sub-simple-collection')[x-1].css('a.Tile__title-link').css('div')[y].text
            m=Movie.new(movie)
            y+=1
            counter+=1
        end

        #presents user all the movie titles inside the selected category
        Movie.all.each do |each|
            puts "#{Movie.all.index(each)+1}.  #{each.name}"
        end


        print "\nplease choose the movie you want to learn about. Enter a valid number: "
        movie_index=gets.chomp.to_i

        puts "Before we proceed, want to go back to the Hulu category?"
        puts "Y = YES,  N = NO, I WANT TO PROCEED WITH MY CURRENT SELECTION"
        puts "Y / N ?\n"

        inp=gets.chomp.upcase
        if inp=="Y"
            Movie.destroy_all
            list_categories
        else

            puts "\n You Chose #{movie_index}.  #{Movie.find_movie(movie_index)}"
            puts " "
            Movie.destroy_all
            display_detail(@category_index,movie_index)
        end

    end

    #method takes 'category index' and 'movie index as arguments'
    #creates object from Detail class and passes that arguments inside another
    #method inside that object
    def display_detail(x,y)
        detail=Detail.new(x,y)
        detail.print_details
    end

end
