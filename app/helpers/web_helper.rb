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

  def web_hr_travel_destinations destionations
    destionations.map{|destionation| destionation.country.zh_name}.join('，')
  end
end