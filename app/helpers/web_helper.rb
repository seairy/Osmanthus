module WebHelper
  def web_ar_t attribute
    t "activerecord.attributes.#{attribute}"
  end

  def web_am_t attribute
    t "activemodel.attributes.#{attribute}"
  end

  def web_date date
    date.try(:strftime, '%Y-%m-%d') || 'N/A'
  end

  def web_time date
    date.try(:strftime, '%H:%M') || 'N/A'
  end

  def web_datetime datetime
    datetime.try(:strftime, '%Y-%m-%d %H:%M') || 'N/A'
  end

  def web_boolean boolean
    boolean ? '是' : '否'
  end

  def web_price price
    price.round
  end

  def hr_travel_destinations destionations
    destionations.map{|destionation| destionation.country.zh_name}.join('、')
  end

  def hr_deal_acceptable_price acceptable_price, options = {}
    if acceptable_price.blank?
      '不限'
    elsif acceptable_price.in_foreign.blank?
      "#{web_price(acceptable_price.in_local)}元(CNY)"
    else
      price = "#{web_price(acceptable_price.in_foreign)}#{acceptable_price.currency.name_with_code}"
      price += " / <span class=\"text-grey\">#{web_price(acceptable_price.in_local)}元(CNY)</span>" if options[:with_local]
      raw(price)
    end
  end

  def wechat_config_tag options = {}
    timestamp = Time.now.to_i
    nonce = SecureRandom.urlsafe_base64
    options[:permissions] ||= [:onMenuShareAppMessage, :onMenuShareTimeline]
    signature = Digest::SHA1.hexdigest("jsapi_ticket=#{Wechat::Base.jsapi_ticket}&noncestr=#{nonce}&timestamp=#{timestamp}&url=#{request.original_url}")
    raw "wx.config({
      debug: true,
      appId: '#{Setting.key[:wechat][:appid]}',
      timestamp: #{timestamp},
      nonceStr: '#{nonce}',
      signature: '#{signature}',
      jsApiList: [#{options[:permissions].map{|i| "'#{i}'"}.join(', ')}]
    });"
  end

  def navbar_default_tag
    raw "<nav class=\"w-nav-menu nav-menu bg-gradient\" role=\"navigation\">
          <div class=\"nav-menu-header\">
            <div class=\"logo\">小信鸽</div>
          </div>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"#{url_for(web_home_path)}\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-home-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">首页</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"#{url_for(set_destinations_new_web_travel_path)}\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-paper-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">创建新行程</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"#{url_for(owned_web_travels_path)}\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-calendar-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">我的行程</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"#{url_for(owned_web_deals_path)}\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-cart-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">我的需求</div>
          </a>
          <div class=\"separator-bottom\"></div>
          <div class=\"separator-bottom\"></div>
          <div class=\"separator-bottom\"></div>
        </nav>"
  end
end