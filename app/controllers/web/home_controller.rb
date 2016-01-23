# -*- encoding : utf-8 -*-
class Web::HomeController < Web::BaseController
  skip_before_action :set_previous_path
  skip_before_action :check_follower
  
  def index
  end

  def follow
  end

  def restore
    Rails.logger.info "************** session['previous_path']: [#{session['previous_path']}]"
    if session['previous_path'].blank?
      redirect_to web_home_path
    else
      redirect_to session['previous_path']
    end
  end
end