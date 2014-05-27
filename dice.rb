############################################################
#
#  Name:        Sean Glover
#  Assignment:  Character Playoff
#  Date:        05/152013
#  Class:       CIS 283
#  Description: Character Fight game - Dice Class
#
############################################################

class Dice

  def initialize(sides_of_dice)
    @sides_of_dice = sides_of_dice
  end

  def roll #returns random number between 1 and @sides_of_dice
    return rand(1..@sides_of_dice)
  end

end