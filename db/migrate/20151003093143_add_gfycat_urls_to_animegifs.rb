class AddGfycatUrlsToAnimegifs < ActiveRecord::Migration
  def change
    add_column :animegifs, :mp4url, :string
    add_column :animegifs, :webmurl, :string
  end
end
