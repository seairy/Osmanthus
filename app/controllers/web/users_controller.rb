# -*- encoding : utf-8 -*-
class Web::UsersController < Web::BaseController
  skip_before_action :authenticate, only: %w(create_faker)
  skip_before_action :set_current_user, only: %w(create_faker)

  def create_faker
    User.create_faker.tap do |user|
      user.update!(nickname: Faker::Name.name)
      session[:user] = { id: user.id }
    end
    redirect_to web_home_path
  end
end