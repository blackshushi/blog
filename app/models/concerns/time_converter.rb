module TimeConverter
	extend ActiveSupport::Concern

	def humanize(secs)
	  duration = [[60, :seconds], [60, :minutes], [24, :hours], [Float::INFINITY, :days]].map{ |count, name|
	    if secs > 0
	      secs, n = secs.divmod(count)

	      "#{n.to_i} #{name}" unless n.to_i==0
	    end
	  }.compact.reverse.join(' ')

	  if duration.empty?
	  	duration = "0 seconds"
	  end

	  duration + " ago" 
	end
end
