class AddApiTypeToApiLol < ActiveRecord::Migration
  def change
    add_column :api_lols, :api_type, :string
  end
end
