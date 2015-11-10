class AddRedditUrlToAnimeGif < ActiveRecord::Migration
  def change
    add_column :animegifs, :redditurl, :string
  end
end
