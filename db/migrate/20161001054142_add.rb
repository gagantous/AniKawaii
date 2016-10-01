class Add < ActiveRecord::Migration
  def change
  	add_column :api_lols,:img,:string
  end
end
