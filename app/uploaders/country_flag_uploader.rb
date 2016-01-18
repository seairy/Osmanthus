# -*- encoding : utf-8 -*-
class CountryFlagUploader < BaseUploader
  version :w60_h40_fl_q100 do
    process quality: 100
    process resize_to_fill: [60, 40]
  end
end