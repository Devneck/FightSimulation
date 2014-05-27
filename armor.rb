############################################################
#
#  Name:        Sean Glover
#  Assignment:  Character Playoff
#  Date:        05/152013
#  Class:       CIS 283
#  Description: Character Fight game - Armor Class
#
############################################################

class Armor
  attr_reader :hits

  def initialize(name, hits)
    @name = name
    @hits = hits.to_i
  end

  def to_s
    return "Armor: #{@name}\nArmor Hits: #{@hits}"
  end

end