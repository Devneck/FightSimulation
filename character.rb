############################################################
#
#  Name:        Sean Glover
#  Assignment:  Character Playoff
#  Date:        05/152013
#  Class:       CIS 283
#  Description: Character Fight game - Character Class
#
############################################################

class Character
  attr_reader :name, :hit_points, :strength, :agility
  attr_accessor :current_hit_points

  def initialize(name, race, hit_points, strength, agility, weapon, armor)
    @name = name
    @race = race
    @hit_points = hit_points.to_i
    @current_hit_points = hit_points.to_i
    @strength = strength.to_i
    @agility = agility.to_i
    @weapon = weapon
    @armor = armor
  end

  def to_s # print out details about the character
    return "Name: #{@name}\nRace: #{@race}\nHit Points: #{@hit_points}\nCurrent Hit Points: #{@current_hit_points}\nStrength: #{@strength}\nAgility: #{@agility}\n#{@weapon.to_s}\n#{@armor.to_s}"
  end

  def current_status # print out the current status of this character
    return "Name: #{@name}\nCurrent Hit Points: #{@current_hit_points}"
  end

  def revive_character # resets character's current_hits to original hits
    @current_hit_points = @hit_points
  end

  def reduce_hits(minus_hp) # removes some of hits from character
    @current_hit_points -= minus_hp
    if @current_hit_points < 0
      @current_hit_points = 0
    end

  end

end