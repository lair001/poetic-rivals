module ApplicationHelper
	include PagesHelper::Titles
	include PagesHelper::Taglines
	include RoutesHelper::Base
	include RoutesHelper::Mapper
	include AuthorizationHelper::Access
	include AuthorizationHelper::Pundit

	include EnvHelper
	include UsersHelper

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
