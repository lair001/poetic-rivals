module ConcernsHelper
	module TimeHelper

		def render_date(time)
			time.strftime("%Y/%m/%d")
		end

		alias_method :display_date, :render_date

		def render_time(time)
			time.strftime("%H:%M:%S")
		end

		alias_method :display_time, :render_time

		def format_time(time)
			time.strftime("%Y/%m/%d<br>@ %H:%M:%S")
		end

	end
end