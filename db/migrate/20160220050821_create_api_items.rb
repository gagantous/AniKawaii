class CreateApiItems < ActiveRecord::Migration
  def change
    create_table :api_items do |t|
      t.string :link
      t.string :image
      t.string :api_type
      t.string :image_thumbnail

      t.timestamps null: false
    end
  end
end
