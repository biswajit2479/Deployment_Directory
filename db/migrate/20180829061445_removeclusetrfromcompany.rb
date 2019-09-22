class Removeclusetrfromcompany < ActiveRecord::Migration[5.1]
  def change
  	remove_column :companies, :cluster
  end
end
