class ApiDota < ActiveRecord::Base
  mount_uploader :full_img, DefaultUploader
end
