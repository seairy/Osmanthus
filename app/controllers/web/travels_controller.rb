# -*- encoding : utf-8 -*-
class Web::TravelsController < Web::BaseController
  before_action :find_travel, only: %w(show edit update)
  skip_before_action :check_follower, only: %w(show)
  
  def index
    @travels = @current_user.travels.page(params[:page])
  end
  
  def show
    ddd
    if @travel.user.id == @current_user.id
      @deals = @travel.deals.order("FIELD(state, 'in_process', 'success', 'failure')").order(created_at: :desc)
      @handled_deals_count, @total_deals_count = @deals.select{|deal| !deal.in_process?}.count, @deals.count
      @completion = ((@handled_deals_count.to_f / @total_deals_count.to_f) * 100).round(2)
      @completion = 0 if @completion.nan?
      render 'owner_show'
    else
      set_previous_path
      render 'others_show'
    end
  end

  def set_destinations
    @country_ids = params[:country_ids].try(:split, ',') || []
  end
  
  def new
    begin
      @travel = Travel.new
      raise ParameterIsEmpty.new if (@country_ids = params[:country_ids].try(:split, ',')).blank?
      @countries = Country.find(@country_ids)
    rescue ParameterIsEmpty
      (@travel = Travel.new).errors.add(:base, '至少选择一个国家或地区')
      render action: 'set_destinations'
    end
  end
  
  def edit
  end
  
  def create
    begin
      raise CountryIsEmpty.new if (@country_ids = params[:country_ids].try(:split, ',')).blank?
      @countries = [Country.find(@country_ids)].flatten
      @travel = @current_user.travels.new(travel_params)
      if @travel.save
        @travel.set_destinations!(@countries)
        redirect_to [:web, @travel]
      else
        render action: 'new'
      end
    rescue CountryIsEmpty
      (@travel = Travel.new).errors.add(:base, '至少选择一个国家或地区')
      render action: 'set_destinations'
    rescue ActiveRecord::RecordNotFound
      (@travel = Travel.new).errors.add(:base, '无效的国家或地区')
      render action: 'new'
    end
  end
  
  def update
    if @travel.update(travel_params)
      redirect_to @travel, notice: '操作成功！'
    else
      render action: 'edit'
    end
  end

  def owned
    @travels = @current_user.travels.order(created_at: :desc).page(params[:page])
  end

  protected
    def travel_params
      params.require(:travel).permit!
    end

    def find_travel
      @travel = Travel.find(params[:id])
    end
end