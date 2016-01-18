class Destination < ActiveRecord::Base
  belongs_to :travel
  belongs_to :country
end