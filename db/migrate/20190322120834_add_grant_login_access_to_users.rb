class AddGrantLoginAccessToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :grant_login_access, :boolean
    add_column :users, :active_status, :boolean
  end
end
