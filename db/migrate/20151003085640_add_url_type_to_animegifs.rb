class AddUrlTypeToAnimegifs < ActiveRecord::Migration
  def change
    add_column :animegifs, :urlType, :string
  end
end
