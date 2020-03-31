require_relative 'scraper.rb'

class Cli


    def run
        scraper=Scraper.new
        scraper.list_categories
        print "\nGo to the main menu again? Y / N ?"
        input=gets.chomp.upcase

        if input=="Y"
            self.run
        else
            puts " Have a good day! "
        end
    end

end

cli=Cli.new
cli.run
