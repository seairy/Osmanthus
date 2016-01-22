# -*- encoding : utf-8 -*-
class Web::DealsController < Web::BaseController
  before_action :find_deal, only: %w(show edit update destroy finish abort)
  before_action :find_travel, only: %w(new create)
  
  def index
    @deals = @current_user.deals.page(params[:page])
  end
  
  def show
    if @deal.user.id == @current_user.id
      render 'owner_show'
    else
      render 'others_show'
    end
  end
  
  def new
    @deal = Deal.new
  end
  
  def edit
  end
  
  def create
    @deal = @current_user.deals.new(deal_params.merge(travel: @travel))
    if @deal.save
      redirect_to [:web, @deal.travel]
    else
      render action: 'new'
    end
  end
  
  def update
    if @deal.update(deal_params)
      @deal.update_acceptable_price!
      redirect_to [:web, @deal.travel]
    else
      render action: 'edit'
    end
  end

  def destroy
    @deal.destroy
    redirect_to [:web, @deal.travel]
  end

  def owned
    @deals = @current_user.deals.order(created_at: :desc).page(params[:page])
  end

  def finish
    @deal.finish!
    redirect_to [:web, @deal.travel]
  end

  def abort
    @deal.abort!
    redirect_to [:web, @deal.travel]
  end

  protected
    def deal_params
      params.require(:deal).permit!
    end

    def find_deal
      @deal = (@current_user.deals.where(id: params[:id]).first || Deal.where(travel_id: @current_user.travels.map(&:id)).where(id: params[:id]).first ||raise(ActiveRecord::RecordNotFound))
    end

    def find_travel
      @travel = Travel.find(params[:travel_id])
    end
end