# -*- encoding : utf-8 -*-
class DealPhotographFileUploader < BaseUploader
  version :w100_h100_fl_q60 do
    process quality: 60
    process resize_to_fill: [100, 100]
  end
end