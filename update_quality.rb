require 'award'

# Use this code if not allowed to change Award. 

# runs each day
def update_quality(awards)
  awards.each do |award|
    next if unchanging(award)

    change = award_change(award)
    if award.expires_in <= 0
      change = expire_adjustment(award, change)
    end

    award.quality += change

    #adjust for mins & maxes
    award.quality = [award.quality, 50].min
    award.quality = [award.quality, 0].max

    award.expires_in -= 1
  end
end


def award_change(award)
  case award.name
    when 'Blue First'
     1
    when 'Blue Compare'
      case award.expires_in  
      when 6..10
        2
      when 1..5
        3
      else
        1
      end      
    when 'Blue Star'
      -2
    else # Normal award
      -1
  end
end

# adjust after expiration
def expire_adjustment(award, change)
  case award.name
    when 'Blue Compare'
      -award.quality
    else
      change * 2
  end
end

def unchanging(award)
  award.name == 'Blue Distinction Plus'
end