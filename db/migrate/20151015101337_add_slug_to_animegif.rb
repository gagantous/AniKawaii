class AddSlugToAnimegif < ActiveRecord::Migration
  def change
    add_column :animegifs, :slug, :string
  end
end
