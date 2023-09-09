class AddStripeSubscriptionDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :plan, :string
    add_column :users, :subscription_status, :string
    add_column :users, :subscription_ends_at, :datetime
  end
end
