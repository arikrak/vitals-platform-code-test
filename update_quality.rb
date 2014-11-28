require 'award'

def update_quality(awards)
  awards.each do |award|
    award.update_quality
    award.increment_expiration
  end
end