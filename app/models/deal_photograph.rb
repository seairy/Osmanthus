class DealPhotograph < ActiveRecord::Base
  mount_uploader :file, DealPhotographFileUploader
  as_enum :type, [:sample, :real], prefix: true, map: :string

  class << self
    def create_with_wechat! options = {}
      create!(type: options[:type], remote_file_url: "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=#{Wechat::Base.access_token}&media_id=#{options[:media_id]}")
    end
  end
end