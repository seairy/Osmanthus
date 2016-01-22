class Country < ActiveRecord::Base
  include Identifierable
  mount_uploader :flag, CountryFlagUploader
  has_many :circulations
  has_many :currencies, through: :circulations
  scope :alphabetic, -> { order('CONVERT(countries.zh_name USING GBK) asc') }
end