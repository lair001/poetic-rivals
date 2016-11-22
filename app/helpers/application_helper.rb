module ApplicationHelper
	include PagesHelper::Titles
	include PagesHelper::Taglines
	include RoutesHelper::Base
	include RoutesHelper::Mapper
	include AuthorizationHelper::Access
	include AuthorizationHelper::Pundit

	include EnvHelper
	include UsersHelper


end
