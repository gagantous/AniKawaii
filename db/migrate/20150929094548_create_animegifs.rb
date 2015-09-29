class CreateAnimegifs < ActiveRecord::Migration
  def change
    create_table :animegifs do |t|
   		 t.string :name
   		 t.string :url
   		 t.integer :score
      	
    	t.timestamps
    end
  end
end
