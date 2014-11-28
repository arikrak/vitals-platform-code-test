class Award
	attr_accessor :name, :expires_in, :quality

	def initialize(name, expires_in, quality)
		@name = name
		@expires_in = expires_in
		@quality = quality

		begin
			extend Object.const_get(name.delete(" "))
		rescue
		end
	end	

	def update_quality
		change = base_change
    	change = adjust_expired(change) if expires_in <= 0

    	@quality += change
		@quality = [@quality, 50].min
		@quality = [@quality, 0].max
	end

	def increment_expiration
		@expires_in -= 1
	end

  private
	def base_change
		-1
	end

	def adjust_expired(change)		
		change * 2
	end
end

module BlueFirst
	def base_change
		1
	end
end

module BlueCompare
	def base_change
		case @expires_in
		when 6..10
		2
		when 1..5
		3
		else
		1
		end
    end

    def adjust_expired(change)
    	- @quality
    end
end

module BlueStar
	def base_change
		-2
	end
end

module BlueDistinctionPlus
	def update_quality
	end

	def increment_expiration
	end
end