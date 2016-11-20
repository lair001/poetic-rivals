# require 'capybara_spec_helper'

def use_controller_to_login_as(user)
  params = {
    forum_user: { username: "#{user.username}", password: "#{user.password}" }
  }
  post helper.login_path, params
end