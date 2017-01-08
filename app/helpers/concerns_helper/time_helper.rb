module ConcernsHelper
	module TimeHelper

		def display_date(time)
			time.strftime("%Y/%m/%d")
		end

		def display_time(time)
			time.strftime("%H:%M:%S")
		end

		def format_time(time)
			time.strftime("%Y/%m/%d<br>@ %H:%M:%S")
		end

	end
end