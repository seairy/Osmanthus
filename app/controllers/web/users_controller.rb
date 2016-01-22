# -*- encoding : utf-8 -*-
class Web::UsersController < Web::BaseController
  skip_before_action :authenticate, only: %w(create_faker)
  skip_before_action :set_current_user, only: %w(create_faker)
  skip_before_action :check_follower, only: %w(create_faker)

  def create_faker
    session[:user] = { id: User.create_faker.id }
    redirect_to web_home_path
  end
end