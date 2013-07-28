class AddStatusAndTdTokenToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :confirm_token, :string
  	add_column :subscriptions, :active, :boolean
  	add_index :subscriptions, :confirm_token
  end
end
