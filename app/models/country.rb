class Country < ActiveRecord::Base
  include Identifierable
  mount_uploader :flag, CountryFlagUploader
  scope :alphabetic, -> { order('CONVERT(countries.zh_name USING GBK) asc') }
end