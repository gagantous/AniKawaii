class ApiDota < ActiveRecord::Base
  mount_uploader :img, DefaultUploader
end
