class ServiceException < ActiveRecord::Base
  as_enum :module, [:web, :admin], prefix: true, map: :string
end