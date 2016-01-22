# -*- encoding : utf-8 -*-
class Web::HomeController < Web::BaseController
  skip_before_action :check_follower, only: %w(index follow)
  
  def index
  end

  def follow
  end

  def restore

  end
end