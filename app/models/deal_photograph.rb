class DealPhotograph < ActiveRecord::Base
  mount_uploader :file, DealPhotographFileUploader
  as_enum :type, [:sample, :real], prefix: true, map: :string
end