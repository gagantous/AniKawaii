class AddItemsToApiDota < ActiveRecord::Migration
  def change
    add_column :api_dota, :full_img, :string
  end
end
