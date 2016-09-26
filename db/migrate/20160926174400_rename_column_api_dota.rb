class RenameColumnApiDota < ActiveRecord::Migration
  def self.up
    rename_column :api_dota, :full_img, :img
  end

  def self.down
    # rename back if you need or do something else or do nothing
    rename_column :api_dota, :img, :full_img
  end
end
