class CreateApiLols < ActiveRecord::Migration
  def change
    create_table :api_lols do |t|
      t.string :link
      t.string :thumb
      t.string :image

      t.timestamps null: false
    end
  end
end
