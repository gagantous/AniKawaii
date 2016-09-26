class RenameApiItemsToApiDota < ActiveRecord::Migration
  def self.up
    rename_table :api_items, :api_dota
  end

  def self.down
    rename_table :api_dota, :api_items
  end
end
