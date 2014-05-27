############################################################
#
#  Name:        Sean Glover
#  Assignment:  Character Playoff
#  Date:        05/152013
#  Class:       CIS 283
#  Description: Character Fight game
#
############################################################

require_relative "armor.rb"
require_relative "menu.rb"
require_relative "character.rb"
require_relative "dice.rb"
require_relative "weapons.rb"

# create Dice objects
roll2 = Dice.new(2)
roll4 = Dice.new(4)
roll8 = Dice.new(8)
roll10 = Dice.new(10)
roll15 = Dice.new(15)

# call new menu class
menu = Menu.new(
    "Load Character 1",
    "Load Character 2",
    "Fight",
    "Quit"
)

# method to load character data from text file
def load_char(character_name)
  # condition to check if user entered character name has associated file
  if File.exists?("#{character_name}.txt")
    # open file and initialize hash
    character_file = File.open("#{character_name}.txt")
    character_array = []
    # loop through file for array population
    while ! character_file.eof?
      # read each line from file
      line = character_file.gets.chomp

      # split each line on tab
      data_array = line.split(",")

      # populate array from character file
      character_array << data_array
    end

    # close file
    character_file.close

    return character_array
  end
end

# print all character's status
def print_status(player1, player2)
  puts "Character Status:"
  puts player1.current_status
  puts player2.current_status
end

# calculate hit point damage
def calc_hit_damage(player, weapon, roll4, roll8)
  ret_str = (player.strength * (1.0/roll4.roll) + weapon.hits/roll8.roll).to_i
  return ret_str
end

# calculate armor save damage
def calc_armor_save(player, armor, roll15)
  ret_str = (armor.hits/roll15.roll).to_i
  return ret_str
end

# determine if character hits or misses
def hit_or_miss(player, roll10)
  hit_roll = roll10.roll

  if hit_roll < player.agility
    return "hit"
  end
end

# method to handle fights
def fight(player1, weapon1, armor1, player2, weapon2, armor2, roll4, roll8, roll10, roll15)
  # first player rolls for hit or miss
  result = hit_or_miss(player1, roll10)

  # proceed when first player hits
  if result == "hit"
    # calculate hit amount
    hit = calc_hit_damage(player1, weapon1, roll4, roll8)
    # calculate defensive save amount
    save = calc_armor_save(player2, armor2, roll15)

    # display hits and saves
    puts "#{player1.name} hits for #{hit}"
    puts "#{player2.name}'s armor saves for #{save}"

    # adjustment for save
    if (hit - save) <= 0
      puts "No Damage taken"
    else
      puts "#{player2.name} hp reduced by #{hit - save}"
      player2.reduce_hits(hit - save)
    end

  else # message for player miss
    puts "#{player1.name} misses!"
  end

  puts
  # check second player is still alive
  if player2.current_hit_points > 0
    # second player rolls for hit or miss
    result = hit_or_miss(player2, roll10)

    # proceed when second player hits
    if result == "hit"
      # calculate hit amount
      hit = calc_hit_damage(player2, weapon2, roll4, roll8)
      # calculate defensive save amount
      save = calc_armor_save(player1, armor1, roll15)

      # display hits and saves
      puts "#{player2.name} hits for #{hit}"
      puts "#{player1.name}'s armor saves for #{save}"

      # adjustment for save
      if (hit - save) <= 0
        puts "No Damage taken"
      else
        puts "#{player1.name} hp reduced by #{hit - save}"
        player1.reduce_hits(hit - save)
      end

    else # message for player miss
      puts "#{player2.name} misses!"
    end
  end

end

character_1 = ""
character_2 = ""
first_char = ""
second_char = ""

# loop through menu until user exits
while ((user_option = menu.run_menu) != menu.quit)

  if user_option == 1 # load first character
    print "Enter name of first character to load (do not include file extension): "
    character_1 = gets.chomp.downcase

    # check if character has already been loaded
    if character_1 == character_2
      puts "That character has already been loaded as Character 2"

    else # load character 1
      loaded_character = load_char(character_1)

      # create Character object when file exists
      if loaded_character != nil
        first_weapon = Weapon.new(loaded_character[1][0], loaded_character[1][1])
        first_armor = Armor.new(loaded_character[2][0], loaded_character[2][1])
        first_char = Character.new(loaded_character[0][0], loaded_character[0][1], loaded_character[0][2], loaded_character[0][3], loaded_character[0][4], first_weapon, first_armor)


=begin
        #### name, race, hit_points, current_hit_points, strength, agility, weapon, armor
        first_char = Character.new(loaded_character[0][0], loaded_character[0][1], loaded_character[0][2], loaded_character[0][3], loaded_character[0][4], loaded_character[1][0], loaded_character[2][0])
        #### name, hits
        first_weapon = Weapon.new(loaded_character[1][0], loaded_character[1][1])
        #### name, hits
        first_armor = Armor.new(loaded_character[2][0], loaded_character[2][1])
=end
        # create Dice object based on character agility
        first_agile = Dice.new(first_char.agility)
        puts
        puts "Loading..."
        puts first_char.to_s

      else # message that user entered character does not have a file
        puts "#{character_1}.txt was not found"
      end
    end

  elsif user_option == 2 # load second character
    print "Enter name of second character to load (do not include file extension): "
    character_2 = gets.chomp.downcase

    # check if character has already been loaded
    if character_1 == character_2
      puts "That character has already been loaded as Character 1"

    else # load character 2
      loaded_character = load_char(character_2)

      # create Character object when file exists
      if loaded_character != nil
        second_weapon = Weapon.new(loaded_character[1][0], loaded_character[1][1])
        second_armor = Armor.new(loaded_character[2][0], loaded_character[2][1])
        second_char = Character.new(loaded_character[0][0], loaded_character[0][1], loaded_character[0][2], loaded_character[0][3], loaded_character[0][4], second_weapon, second_armor)

=begin
        #### name, race, hit_points, current_hit_points, strength, agility, weapon, armor
        second_char = Character.new(loaded_character[0][0], loaded_character[0][1], loaded_character[0][2], loaded_character[0][3], loaded_character[0][4], loaded_character[1][0], loaded_character[2][0])
        #### name, hits
        second_weapon = Weapon.new(loaded_character[1][0], loaded_character[1][1])
        #### name, hits
        second_armor = Armor.new(loaded_character[2][0], loaded_character[2][1])
=end

        # create Dice object based on character agility
        second_agile = Dice.new(second_char.agility)
        puts
        puts "Loading..."
        puts second_char.to_s

      else # message that user entered character does not have a data file
        puts "#{character_2}.txt was not found"
      end
    end

  elsif user_option == 3 # initiate fight loop
    # check that both characters have been loaded
    if first_char == "" or second_char == ""
      puts "Both characters must be loaded before commencing fight."

    else # initiate fight loop
      # loop until one of the characters hit points is 0
      until first_char.current_hit_points <= 0 or second_char.current_hit_points <= 0
        # roll each round to see which character goes first
        first_roll = first_agile.roll
        second_roll = second_agile.roll

        # condition when first character attacks first
        if first_roll > second_roll
          puts fight(first_char, first_weapon, first_armor, second_char, second_weapon, second_armor, roll4, roll8, roll10, roll15)

        # condition when second character attacks first
        elsif first_roll < second_roll
          puts fight(second_char, second_weapon, second_armor, first_char, first_weapon, first_armor, roll4, roll8, roll10, roll15)
        end
      end # end loop

      # display fight winner
      if first_char.current_hit_points == 0
        puts "#{second_char.name} wins!"
      else
        puts "#{first_char.name} wins!"
      end
      # display both character status
      puts
      print_status(first_char, second_char)

      # revive characters for next round
      first_char.revive_character
      second_char.revive_character
    end

  elsif user_option != 4 # condition for invalid menu option entry
    puts "That is not a valid option."
  end
end


