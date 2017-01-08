module ApplicationHelper

	include ConcernsHelper::AuthorizationHelper::Access
	include ConcernsHelper::AuthorizationHelper::Pundit
	include ConcernsHelper::PagesHelper::Taglines
	include ConcernsHelper::PagesHelper::Titles
	include ConcernsHelper::RoutesHelper::Base
	include ConcernsHelper::RoutesHelper::Mapper

	include ConcernsHelper::CommentariesHelper
	include ConcernsHelper::EnvHelper
	include ConcernsHelper::FlashHelper
	include ConcernsHelper::GenresHelper
	include ConcernsHelper::HtmlHelper
	include ConcernsHelper::JsonHelper
	include ConcernsHelper::ModelsHelper
	include ConcernsHelper::PoemsHelper
	include ConcernsHelper::TimeHelper
	include ConcernsHelper::UsersHelper

end
