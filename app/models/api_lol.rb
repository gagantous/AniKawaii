class ApiLol < ActiveRecord::Base
  mount_uploader :img, DefaultUploader
end
