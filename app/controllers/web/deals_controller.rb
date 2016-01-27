# -*- encoding : utf-8 -*-
class Web::DealsController < Web::BaseController
  before_action :find_deal, only: %w(show edit update destroy buy_form buy abort)
  before_action :find_travel, only: %w(new create)
  
  def index
    @deals = @current_user.deals.page(params[:page])
  end
  
  def show
    if @deal.user.id == @current_user.id
      render 'buyer_show'
    else
      render 'traveller_show'
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
      
    end
  end

  def destroy
    @deal.destroy
    redirect_to [:web, @deal.travel]
  end

  def owned
    @deals = @current_user.deals.order(created_at: :desc).page(params[:page])
  end

  def buy_form
  end

  def buy
    begin
      raise InvalidActualPriceCurrency.new if deal_params[:actual_price_currency_id].blank?
      actual_price_value = deal_params[:actual_price_value].try(:to_f)
      raise InvalidActualPrice.new if actual_price_value.blank? or actual_price_value <= 0
      @deal.buy(deal_params)
      redirect_to [:web, @deal.travel]
    rescue InvalidActualPriceCurrency
      @deal.errors.add(:base, '请选择货币种类')
      render action: 'buy_form'
    rescue InvalidActualPrice
      @deal.errors.add(:base, '请填写实际购买价格')
      render action: 'buy_form'
    rescue DifferentCurrency
      @deal.errors.add(:base, '请选择正确的货币种类')
      render action: 'buy_form'
    rescue UnacceptablePrice
      @deal.errors.add(:base, '实际价格不能高于可接受价格')
      render action: 'buy_form'
    end
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
      @deal = (@current_user.deals.where(id: params[:id]).first || Deal.where(travel_id: @current_user.travels.map(&:id)).where(id: params[:id]).first || raise(ActiveRecord::RecordNotFound))
    end

    def find_travel
      @travel = Travel.find(params[:travel_id])
    end
end