module ApplicationHelper
	include PagesHelper::Titles
	include PagesHelper::Taglines
	include RoutesHelper::Base
	include RoutesHelper::Mapper
	include AuthorizationHelper::Access
	include AuthorizationHelper::Pundit

	include CommentariesHelper
	include EnvHelper
	include FlashHelper
	include GenresHelper
	include ModelsHelper
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

	def render_record_not_found_json
		render json: { errors: [{ status: 404, title: "Record Not Found" }] }.to_json, status: 404
	end

end
