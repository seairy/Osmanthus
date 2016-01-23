# -*- encoding : utf-8 -*-
class Web::ErrorsController < Web::BaseController
  skip_before_action :set_previous_path
  skip_before_action :authenticate
  skip_before_action :set_current_user
  skip_before_action :check_follower
end