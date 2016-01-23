# -*- encoding : utf-8 -*-
class Web::HomeController < Web::BaseController
  skip_before_action :check_follower
  
  def index
  end

  def follow
  end

  def restore
    if session['previous_path'].blank? or session['previous_path'] == request.path
      redirect_to web_home_path
    else
      redirect_to session['previous_path']
    end
  end
end