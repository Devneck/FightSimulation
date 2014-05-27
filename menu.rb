############################################################
#
#  Name:        Sean Glover
#  Assignment:  Character Playoff
#  Date:        05/152013
#  Class:       CIS 283
#  Description: Character Fight game - Menu Class
#
############################################################

class Menu
  attr_reader :quit
  def initialize(*menu_args)
    @menu_args = menu_args
    @quit = @menu_args.length
  end

  def run_menu
    puts
    @menu_args.each_with_index do | item, index|
      puts "#{index + 1}) #{item}"
    end

    print "Enter menu option: "
    user_option = gets.chomp.to_i

    return user_option
  end

end