class AddFieldsToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :user_id, :integer
  	add_column :profiles, :location, :string
  	add_column :profiles, :gender, :string
  	add_column :profiles, :birthday, :date
  end
end
